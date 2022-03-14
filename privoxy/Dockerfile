FROM alpine:latest

LABEL package="privoxy", version="3.0.33-r0"

RUN apk add --update \
        privoxy=3.0.33-r0 \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/privoxy"]
CMD ["--no-daemon", "--pidfile", "/var/run/privoxy.pid", "/etc/privoxy/config"]
