FROM alpine:latest

LABEL package="socat", version="1.8.0.3-r0"

RUN apk add --update \
        socat=1.8.0.3-r0 \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["socat"]
CMD []
