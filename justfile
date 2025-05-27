build:
  docker build . -t shelken/mosdns:test

exec:
  docker run -it --rm --name mosdns-exec --entrypoint /bin/sh shelken/mosdns:test

run:
  docker run -it --rm -p 53:53/udp --name mosdns-run shelken/mosdns:test
