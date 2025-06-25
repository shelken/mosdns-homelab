# mosdns

自用mosdns docker镜像

[配置参考来源](https://github.com/pmkol/easymosdns)

## 变更

- 使用IPV6,不会仅返回v4
- 引入PRIVATE_DNS_SERVER变量，用于自定义自己的上游dns
- 增加short_cache,不再缓存太长时间，目前设定1m

## CheatSheet

- 变更后构建

```shell
just build
```

- 本地测试 进入容器

```shell
just exec 
```

- 本地测试 使用53接口

```shell
just run
```

## mosdns wiki

> [规则写法](https://irine-sistiana.gitbook.io/mosdns-wiki/mosdns-v5/ru-he-pei-zhi-mosdns/yu-ming-pi-pei-gui-ze)
> [hosts写法](https://irine-sistiana.gitbook.io/mosdns-wiki/mosdns-v4/cha-jian-ji-qi-can-shu#yu-ming-pi-pei-gui-ze)