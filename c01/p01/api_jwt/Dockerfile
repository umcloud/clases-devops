FROM golang:1.11.0-alpine as build

ARG SRC_REPO=github.com/c0r0nel/api_jwt
ARG SRC_TAG=master
ARG ARCH=amd64
RUN apk update && apk add --no-cache build-base sqlite

COPY . /go/src/${SRC_REPO}
RUN GOARCH=${ARCH} go get ${SRC_REPO}
RUN find /go/bin -name api_jwt -type f | xargs -I@ install @ /

FROM alpine:3.7

USER 1001
COPY --from=build /api_jwt /opt/api_jwt/bin/api_jwt

ENTRYPOINT [ "/opt/api_jwt/bin/api_jwt" ]
