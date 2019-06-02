FROM alpine:latest

RUN apk add --update \
    postfix \
  && rm -rf /var/cache/apk/*

EXPOSE 25
EXPOSE 465
USER root
WORKDIR "/var/spool/postfix"
ENTRYPOINT ["/usr/libexec/postfix/postfix-script", "start-fg"]
