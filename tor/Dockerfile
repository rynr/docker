FROM alpine:latest

LABEL package="tor", version="0.4.6.9-r0"

RUN apk add --update \
  tor=0.4.6.9-r0 \
  && rm -rf /var/cache/apk/*

EXPOSE 9050
USER tor
ENTRYPOINT tor
