build:
  docker build . -t shelken/mosdns:test

build-test: build
  @just run

exec:
  docker run -it --rm --name mosdns-exec --entrypoint /bin/sh shelken/mosdns:test

remote-exec:
  docker run -it --rm --name mosdns-exec --entrypoint /bin/sh ghcr.io/shelken/mosdns:3.0.4

run:
  docker run -it --rm -p 53:53/udp --name mosdns-run shelken/mosdns:test
