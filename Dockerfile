FROM curlimages/curl:8.6.0 AS downloader
WORKDIR /tmp

RUN set -xe \
  && mkdir -p rules \
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/china_domain_list.txt -o rules/china_domain_list.txt \
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/gfw_domain_list.txt -o rules/gfw_domain_list.txt \ 
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/cdn_domain_list.txt -o rules/cdn_domain_list.txt \ 
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/china_ip_list.txt -o rules/china_ip_list.txt \ 
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/gfw_ip_list.txt -o rules/gfw_ip_list.txt  \ 
  && curl https://raw.githubusercontent.com/pmkol/easymosdns/rules/ad_domain_list.txt -o rules/ad_domain_list.txt

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

# 规则源拷贝
COPY --from=downloader /tmp/rules /etc/mosdns/rules
COPY config/ecs_cn_domain.txt /etc/mosdns/
COPY config/ecs_noncn_domain.txt /etc/mosdns/
COPY config/hosts.txt /etc/mosdns/

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp 8338/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
