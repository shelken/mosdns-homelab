#!/bin/sh

# crond
/usr/sbin/crond -b -l 8

ecs_local_v4=$ECS_LOCAL_IPV4
ecs_local_v6=$ECS_LOCAL_IPV6
private_dns_server=$PRIVATE_DNS_SERVER
router_host=$ROUTER_HOST
remote_dns_server_1=$REMOTE_DNS_SERVER_1
remote_dns_server_2=$REMOTE_DNS_SERVER_2

# 检查环境变量$PRIVATE_DNS_SERVER是否设置
if [ -z "$private_dns_server" ]; then
    # 如果没有设置PRIVATE_DNS_SERVER环境变量，则使用 easymosdns 的默认值
    private_dns_server="https://mosdns.apad.pro/api-query"
    ecs_local_v4="101.6.6.0"
    ecs_local_v6="2001:da8::"
fi

# 检查环境变量$ecs_local是否设置
if [ -z "$ecs_local_v4" ]; then
    # 如果没有设置ECS_LOCAL_CIDR环境变量，则使用默认值
    ecs_local_v4="120.80.1.0" # 广东联通
fi
if [ -z "$ecs_local_v6" ]; then
    ecs_local_v6="2408:8459::" # 广东联通
fi
if [ -z "$router_host" ]; then
    router_host="192.168.6.1" # 没有设置系统路由器地址默认192.168.6.1
fi
if [ -z "$remote_dns_server_1" ]; then
    remote_dns_server_1="1.1.1.1" # 
fi
if [ -z "$remote_dns_server_2" ]; then
    remote_dns_server_2="8.8.8.8" # 
fi

# 替换/etc/mosdns/config.yaml中的变量$private_dns_server
sed -i "s#\$PRIVATE_DNS_SERVER#$private_dns_server#g" /etc/mosdns/config.yaml
sed -i "s#\$ECS_LOCAL_IPV4#$ecs_local_v4#g" /etc/mosdns/config.yaml
sed -i "s#\$ECS_LOCAL_IPV6#$ecs_local_v6#g" /etc/mosdns/config.yaml
sed -i "s#\$ROUTER_HOST#$router_host#g" /etc/mosdns/config.yaml
sed -i "s#\$REMOTE_DNS_SERVER_1#$remote_dns_server_1#g" /etc/mosdns/config.yaml
sed -i "s#\$REMOTE_DNS_SERVER_2#$remote_dns_server_2#g" /etc/mosdns/config.yaml

/usr/bin/mosdns start --dir /etc/mosdns
