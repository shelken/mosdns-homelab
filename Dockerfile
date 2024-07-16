FROM golang:1.19.2-alpine as unpack
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

# FROM curlimages/curl:8.6.0 as downloader
# ADD update-online-config.sh /tmp
# RUN /tmp/update-online-config.sh
FROM irinesistiana/mosdns:latest

LABEL org.opencontainers.image.source=https://github.com/shelken/mosdns-homelab
LABEL org.opencontainers.image.description="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.title="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.authors=shelken

COPY config/config.yaml /etc/mosdns/config.yaml
COPY config/dat_exec.yaml /etc/mosdns/dat_exec.yaml
COPY config/dns.yaml /etc/mosdns/dns.yaml
COPY config/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
# data
COPY config/hosts/custom /etc/mosdns/hosts/custom
COPY --from=unpack /dat /dat

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
