test:
  docker build . -t shelken/mosdns:test

exec:
  docker run --rm -p 5533:5533/udp --name mosdns -it shelken/mosdns:test sh
