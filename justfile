build:
  docker build . -t shelken/mosdns:test

build-test: build
  @just run

exec:
  docker run -it --rm --name mosdns-exec --entrypoint /bin/sh shelken/mosdns:test

run:
  docker run -it --rm -p 53:53/udp -v "./config/short_cache.txt:/etc/mosdns/short_cache.txt:ro" --name mosdns-run shelken/mosdns:test
