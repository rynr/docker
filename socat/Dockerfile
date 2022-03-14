FROM alpine:latest

LABEL package="socat", version="1.7.4.2-r0"

RUN apk add --update \
        socat=1.7.4.2-r0 \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["socat"]
CMD []
