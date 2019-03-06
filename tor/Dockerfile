FROM alpine:latest

RUN apk add --update \
    tor \
  && rm -rf /var/cache/apk/*

EXPOSE 9050
USER tor
ENTRYPOINT tor
