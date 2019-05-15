FROM golang:1.12-alpine3.9 AS builder

COPY . /go/src/api_jwt/
RUN apk update && apk add build-base
# The sqlite3 go driver needs to be compiled with CGO enabled
RUN set -ex && \
  cd /go/src/api_jwt && \
      CGO_ENABLED=1 go build ./api_jwt.go && \
  mv ./api_jwt /usr/bin/api_jwt

FROM alpine:3.9

# Retrieve the binary from the previous stage
COPY --from=builder /usr/bin/api_jwt /opt/api_jwt/bin/api_jwt
# Set the binary as the entrypoint of the container
ENTRYPOINT [ "/opt/api_jwt/bin/api_jwt" ]
