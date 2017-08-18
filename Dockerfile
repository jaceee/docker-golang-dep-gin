FROM golang:1.8

RUN mkdir -p /go/src/app
WORKDIR /go/src/app

RUN go get -u github.com/golang/dep/cmd/dep github.com/codegangsta/gin

ENV GOPATH /go/src/app/.gopath:/go/src/app/vendor:$GOPATH

ENV APP_PORT 8080
ENV PROXY_PORT 3000

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
