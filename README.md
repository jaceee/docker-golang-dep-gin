docker-golang-dep-gin
-----

An image to debug golang web servers using
[go dep](https://github.com/golang/dep) for vendoring and [gin](https://github.com/codegangsta/gin) for live-reloading.

The only supported setup is as follows:

```
yourpackage
|-- .gopath
| |-- yourpackage (symlink)
|-- vendor
| |-- github.com
|   |-- random
|     |-- library
|-- Gopkg.toml
|-- Gopkg.lock
|-- subpkg
| |-- subpkg.go
| |-- subsubpkg
|   |-- subsubpkg.go
|-- main.go
```


## Usage

Run this image with your source mounted on `/go/src/app`. Use `APP_PORT`
environment variable to set the port your app listens to (defaults to 8080),
and `PROXY_PORT` to set the port gin will listen to (defaults to 3000).

```
docker run --name some-app-debug -v $(pwd):/go/src/app -e APP_PORT=8085 -p 3000:3000 jace/golang-dep-gin:latest
```

Or use a docker-compose.yml

```yaml
version: '3'

services:
  server:
    image: jace/golang-dep-gin:latest
    volumes:
      - .:/go/src/app
    environment:
      - "APP_PORT=8085"
    ports:
      - "3000:3000"
```
