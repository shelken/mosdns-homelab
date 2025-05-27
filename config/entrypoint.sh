#!/bin/sh

# crond
/usr/sbin/crond -b -l 8

# 检查环境变量$PRIVATE_DNS_SERVER是否设置
if [ -z "$PRIVATE_DNS_SERVER" ]; then
  echo "Error: Environment variable PRIVATE_DNS_SERVER is not set."
  exit 1
fi

# 替换/etc/mosdns/config.yaml中的变量$PRIVATE_DNS_SERVER
sed -i "s#\$PRIVATE_DNS_SERVER#$PRIVATE_DNS_SERVER#g" /etc/mosdns/config.yaml

/usr/bin/mosdns start --dir /etc/mosdns
