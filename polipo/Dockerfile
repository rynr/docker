FROM alpine:latest

LABEL package="polipo", version="1.1.1-r0"

RUN apk add --update \
        polipo=1.1.1-r0 \
    && rm -rf /var/cache/apk/*

EXPOSE 8123
ENTRYPOINT ["polipo"]
CMD []
