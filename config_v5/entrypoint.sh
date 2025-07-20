#!/bin/sh

# crond
/usr/sbin/crond -b -l 8

ecs_local_v4=$ECS_LOCAL_IPV4
router_host=$ROUTER_HOST
remote_dns_server_1=$REMOTE_DNS_SERVER_1
remote_dns_server_2=$REMOTE_DNS_SERVER_2


# 检查环境变量$ecs_local是否设置
if [ -z "$ecs_local_v4" ]; then
    # 如果没有设置ECS_LOCAL_CIDR环境变量，则使用默认值
    ecs_local_v4="120.80.1.0" # 广东联通
fi
if [ -z "$router_host" ]; then
    router_host="192.168.6.1" # 没有设置系统路由器地址默认192.168.6.1
fi
if [ -z "$remote_dns_server_1" ]; then
    remote_dns_server_1="tls://1.0.0.1" # 
fi
if [ -z "$remote_dns_server_2" ]; then
    remote_dns_server_2="tls://1.1.1.1" # 
fi

# 替换/etc/mosdns/config.yaml中的变量$private_dns_server
sed -i "s#\$ECS_LOCAL_IPV4#$ecs_local_v4#g" /etc/mosdns/dat_exec.yaml
sed -i "s#\$ROUTER_HOST#$router_host#g" /etc/mosdns/dns.yaml
sed -i "s#\$REMOTE_DNS_SERVER_1#$remote_dns_server_1#g" /etc/mosdns/dns.yaml
sed -i "s#\$REMOTE_DNS_SERVER_2#$remote_dns_server_2#g" /etc/mosdns/dns.yaml

/usr/bin/mosdns start --dir /etc/mosdns
