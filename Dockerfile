FROM golang:1.8-alpine

RUN mkdir -p /go/src/app
WORKDIR /go/src/app

RUN apk --no-cache add curl git mercurial bzr && \
    go get -u github.com/golang/dep/cmd/dep github.com/codegangsta/gin

ENV APP_NAME app
ENV APP_PORT 8080
ENV PROXY_PORT 3000

ENV VERBOSE false

ADD entrypoint.py /
RUN chmod 755 /entrypoint.py && chmod +x /entrypoint.py

ENTRYPOINT ["/entrypoint.py"]
