test:
  docker build . -t shelken/mosdns:test

exec:
  touch /tmp/host-custom
  docker run --rm -v /tmp/host-custom:/etc/mosdns/hosts/custom -p 5533:53/udp --name mosdns -it shelken/mosdns:test sh
