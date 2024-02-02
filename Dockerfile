# FROM curlimages/curl:8.6.0 as downloader
# ADD update-online-config.sh /tmp
# RUN /tmp/update-online-config.sh
FROM irinesistiana/mosdns:v5.3.1

WORKDIR /etc/mosdns/online_rules
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/apple-cn.txt     apple_cn.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/direct-list.txt  direct_list.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/proxy-list.txt   proxy_list.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/reject-list.txt  reject_list.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/google-cn.txt    google_cn.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/gfw.txt          gfw.txt
ADD https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/greatfire.txt    greatfire.txt

WORKDIR /etc/mosdns
COPY config/custom_rules    custom_rules
COPY config/hosts.d         hosts.d
COPY config/config.yaml     .

EXPOSE 5533