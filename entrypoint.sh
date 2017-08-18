#!/bin/sh

cd /go/src/app
exec dep ensure && gin --laddr="0.0.0.0" --port="$PROXY_PORT" --appPort="$APP_PORT" run main.go
