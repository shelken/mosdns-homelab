# mosdns

自用mosdns docker镜像

[配置参考来源](https://blog.picopock.com/2023/02/12/debian/debian/#toc-heading-18)

## CheatSheet

- 变更后构建

```shell
docker-buildx build . --platform linux/arm64,linux/amd64 --tag shelken/mosdns:v1.0.x --tag shelken/mosdns:latest --builder=multi-arch-build --push
```

- 本地测试

```shell
# for arm
docker-buildx build . --platform linux/arm64 --tag shelken/mosdns:latest --builder=multi-arch-build --load
```

## mosdns wiki

> [规则写法](https://irine-sistiana.gitbook.io/mosdns-wiki/mosdns-v5/ru-he-pei-zhi-mosdns/yu-ming-pi-pei-gui-ze)
