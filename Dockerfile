## adapting https://hub.docker.com/r/cfssl/cfssl/~/dockerfile/ to build a smaller image

FROM golang:alpine as BUILD

ENV VERSION 1.3.1

WORKDIR /go/src/github.com/cloudflare/cfssl
COPY . .

RUN set -x \
  \
  && apk add --no-cache \
    git \
    g++ \
    libressl \
  \
  && wget -O cfssl.tar.gz https://github.com/cloudflare/cfssl/archive/$VERSION.tar.gz \
  && tar xf cfssl.tar.gz --strip-components=1 \
  && rm cfssl.tar.gz \
  \
  && go get github.com/cloudflare/cfssl_trust/... \
  && go get github.com/GeertJohan/go.rice/rice \
  && rice embed-go -i=./cli/serve \
  && cp -R /go/src/github.com/cloudflare/cfssl_trust /etc/cfssl \
  && go install ./cmd/...

FROM alpine:latest

COPY --from=BUILD /go/bin /usr/local/bin/

EXPOSE 8888

ENTRYPOINT ["cfssl"]
CMD ["--help"]