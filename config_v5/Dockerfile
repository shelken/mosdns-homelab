FROM golang:1.19.2-alpine AS unpack
WORKDIR /

RUN set -xe \
  && apk add --no-cache curl \
  && go install github.com/urlesistiana/v2dat@latest \
  && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
  && curl -LJO https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
  && mkdir dat \
  && v2dat unpack geoip -o dat -f "private" geoip.dat \
  && v2dat unpack geoip -o dat -f "cn" geoip.dat \
  && v2dat unpack geosite -o dat -f "cn" geosite.dat \
  && v2dat unpack geosite -o dat -f "gfw" geosite.dat \
  && v2dat unpack geosite -o dat -f "category-ads-all" geosite.dat \
  && v2dat unpack geosite -o dat -f "geolocation-!cn" geosite.dat


FROM irinesistiana/mosdns:v5.3.3
LABEL org.opencontainers.image.source=https://github.com/shelken/mosdns-homelab
LABEL org.opencontainers.image.description="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.title="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.authors=shelken

COPY rules /etc/mosdns/rules
COPY ./config.yaml /etc/mosdns/config.yaml
COPY ./dat_exec.yaml /etc/mosdns/dat_exec.yaml
COPY ./dns.yaml /etc/mosdns/dns.yaml
COPY ./entrypoint.sh /entrypoint.sh
COPY --from=unpack /dat /dat
RUN chmod a+x /entrypoint.sh

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp
# CMD /usr/bin/mosdns start --dir /etc/mosdns

ENTRYPOINT [ "/entrypoint.sh" ]