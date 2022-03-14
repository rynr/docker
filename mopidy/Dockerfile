FROM alpine:latest

LABEL package="mopidy", version="3.2.0-r3"

RUN apk add --update \
        mopidy=3.2.0-r3 \
    && rm -rf /var/cache/apk/*

EXPOSE 6680 5555/udp
CMD ["/usr/bin/mopidy", "-o", "http/hostname=0.0.0.0"]

