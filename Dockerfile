FROM curlimages/curl:8.6.0 AS downloader
WORKDIR /tmp


# FROM curlimages/curl:8.6.0 as downloader
# ADD update-online-config.sh /tmp
# RUN /tmp/update-online-config.sh
FROM irinesistiana/mosdns:v4.5.3

LABEL org.opencontainers.image.source=https://github.com/shelken/mosdns-homelab
LABEL org.opencontainers.image.description="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.title="自用 mosdns 镜像及配置"
LABEL org.opencontainers.image.authors=shelken

# 主配置
COPY config/config.yaml /etc/mosdns/
COPY config/entrypoint.sh /
RUN chmod a+x /entrypoint.sh

# 用于mosdns日志输出
RUN mkdir /logs && touch /logs/mosdns.log

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp 8338/tcp 9053/tcp

ENTRYPOINT [ "/entrypoint.sh" ]