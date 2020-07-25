#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'nokogiri'
end

require 'erb'
require 'net/http'
require 'nokogiri'
require 'optionparser'

REPO_HOST = 'dl-cdn.alpinelinux.org'

options = {generate: {}}
printers = Array.new
OptionParser.new do |opts|
  opts.banner = "Usage: update [options]"
  opts.on("-v", "--versions <versions>", Array, "Versions (of alpine) to generate (default is latest-stable)") do |versions|
    options[:versions] = versions
  end
  opts.on("-r", "--repositories <repositories>", Array, "Repositories (of alpine) to generate (default is main)") do |repositories|
    options[:repositories] = repositories
  end
  opts.on("-a", "--arch <architectures>", Array, "Architectured (of alpine) to generate (default is x86_64)") do |archs|
    options[:archs] = archs
  end
end.parse!

# verify versions
options[:versions] ||= ['latest-stable']
options[:versions] =  Nokogiri::HTML(Net::HTTP.get_response(REPO_HOST, '/alpine/').body).xpath('//a').map { |a| a['href'].tr('/', '') }.filter { |href| options[:versions].include?(href) }

# verify repositories
options[:repositories] ||= ['main']
options[:versions].each do |version|
  options[:generate][version] = Nokogiri::HTML(Net::HTTP.get_response(REPO_HOST, "/alpine/#{version}/").body).xpath('//a').map { |a|
    a['href'].tr('/', '')
  }.filter {
    |href| options[:repositories].include?(href)
  }.inject({}) do |res, rep|
    res[rep] = {}
    res
  end
end

# verify arch
options[:archs] ||= ['x86_64']
options[:generate].each_key do |version|
  options[:generate][version].each_key do |repo|
    options[:archs].each do |arch|
      options[:generate][version][repo] = Nokogiri::HTML(Net::HTTP.get_response(REPO_HOST, "/alpine/#{version}/#{repo}/").body).xpath('//a').map { |a|
        a['href'].tr('/', '')
      }.filter {
        |href| options[:archs].include?(href)
      }
    end
  end
end

# checking versions
options[:packages] = Dir.entries(".").filter { |f| File.exists?("#{f}/Dockerfile.erb") }

options[:generate].each_key do |version|
  options[:generate][version].each_key do |repo|
    options[:generate][version][repo].each do |arch|
      puts "Checking #{version} / #{repo} / #{arch}"
      Nokogiri::HTML(Net::HTTP.get_response(REPO_HOST, "/alpine/#{version}/#{repo}/#{arch}/").body).xpath('//a').map { |a|
        if match = /([^\.]+)\-(([0-9]+\.)+[0-9]+-r[0-9]+)\.apk/.match(a['href'])
            pkg, ver = match[1,2]
            if options[:packages].include? pkg
              puts [pkg, ver].inspect
              erb = ERB.new(File.read("#{pkg}/Dockerfile.erb"))
              File.open("#{pkg}/Dockerfile.#{version}.#{repo}.#{arch}", 'w') do |file|
                file.write(erb.result(binding()));
              end
            end
        end
      }
    end
  end
end
