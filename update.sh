#!/bin/sh

./update.rb --arch mips64,armv7,s390x,armhf,ppc64le,aarch64,x86,x86_64 -r main,community,testing -v edge,latest-stable
git add -p .

export DOCKER_CLI_EXPERIMENTAL=enabled
