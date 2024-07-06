FROM alpine:latest

LABEL package="arduino-cli", version="latest"

RUN
RUN apk add --update curl \
    && curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh \
    && mkdir /work

WORKDIR /work

ENTRYPOINT ["arduino-cli"]
CMD []

