#!/bin/sh

# crond
/usr/sbin/crond -b -l 8

remote_dns_server_1=$REMOTE_DNS_SERVER_1
remote_dns_server_2=$REMOTE_DNS_SERVER_2

if [ -z "$remote_dns_server_1" ]; then
    remote_dns_server_1="1.1.1.1" # 
fi
if [ -z "$remote_dns_server_2" ]; then
    remote_dns_server_2="8.8.8.8" # 
fi

# 替换/etc/mosdns/config.yaml中的变量$private_dns_server
sed -i "s#\$REMOTE_DNS_SERVER_1#$remote_dns_server_1#g" /etc/mosdns/config.yaml
sed -i "s#\$REMOTE_DNS_SERVER_2#$remote_dns_server_2#g" /etc/mosdns/config.yaml

/usr/bin/mosdns start --dir /etc/mosdns
