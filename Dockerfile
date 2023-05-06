FROM golang:latest AS build-env
RUN GO111MODULE=on go install github.com/w3security/gf@latest
FROM alpine:3.17.1
RUN apk add --no-cache ca-certificates libc6-compat
WORKDIR /app
COPY --from=build-env /go/bin/gf .
RUN mkdir -p /app \
    && adduser -D gf \
    && chown -R gf:gf /app
USER gf
ENTRYPOINT [ "./gf" ]
