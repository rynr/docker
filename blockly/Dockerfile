FROM alpine/git AS build
WORKDIR /tmp
RUN git clone https://github.com/google/blockly.git
RUN mkdir www
WORKDIR /tmp/blockly
RUN for version in `git tag | grep -e '^[0-9]\+\.[0-9]\+\.[0-9]\+'`; do if [ ! -d /tmp/www/$version/msg/js ]; then mkdir -p /tmp/www/$version/msg/js; fi; git checkout -q $version; cp *_compressed.js /tmp/www/$version; cp -r msg/js/* /tmp/www/$version/msg/js; done
RUN echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Blockly</title><link rel="stylesheet" type="text/css" href="https://rynr.github.io/style/style.css"></head><body><h1>Blockly</h1><ul>' >> /tmp/www/index.html
RUN git tag | grep -e '^[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -nr | awk '{ print "<dl><dt>"$0":</dt><dd><a href=\""$0"/blockly_compressed.js\">blockly_compressed.js</a></dd></dt>"}' >> /tmp/www/index.html
RUN echo '</ul><pre>Provided from <a href="https://github.com/google/blockly">blockly</a> under <a href="https://github.com/google/blockly/blob/master/LICENSE">Apache License 2.0</a></pre></body></html>' >> /tmp/www/index.html

FROM nginx:alpine
RUN sed -i '/#charset .*/c\    charset utf-8;' /etc/nginx/conf.d/default.conf
COPY --from=build /tmp/www /usr/share/nginx/html
COPY favicon.ico /usr/share/nginx/html
