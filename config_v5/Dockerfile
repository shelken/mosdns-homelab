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
COPY ./dat /dat
RUN chmod a+x /entrypoint.sh

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp
# CMD /usr/bin/mosdns start --dir /etc/mosdns

ENTRYPOINT [ "/entrypoint.sh" ]