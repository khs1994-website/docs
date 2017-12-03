---
title: 在生产环境使用 Docker
date: 2017-10-18 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文是对官方文档的总结与备注。

官方文档：https://docs.docker.com/engine/userguide/

<!--more-->

# 配置 Docker

## 手动启动 Docker

这一部分内容详情可以查看：https://www.khs1994.com/docker/dockerd.html

```bash
$ sudo docked
```

## 配置 Docker daemon

```bash
$ dockerd -D \
     --tls=true \
     --tlscert=/var/docker/server.pem \
     --tlskey=/var/docker/serverkey.pem \
     -H tcp://192.168.59.3:2376
```

你也可以通过编辑 `daemon.json`

```json
{
  "debug": true,
  "tls": true,
  "tlscert": "/var/docker/server.pem",
  "tlskey": "/var/docker/serverkey.pem",
  "hosts": ["tcp://192.168.59.3:2376"]
}
```

# 自动启动容器

https://docs.docker.com/engine/admin/start-containers-automatically/

```bash
$ docker run --restat no | on-failure | unless-stopped | always
```

# 限制容器资源

https://docs.docker.com/engine/admin/resource_constraints/

## 内存

`-m` 或 `--memory=4m`

`--memory-swap`

`--memory-swappiness`

`--memory-reservation`

`--kernel-memory`

`--oom-kill-disable`

## CPU

`--cpus`

`--cpu-period`

`--cpu-quota`

`--cpuset-cpus`

`--cpu-shares`

# 清除无用数据

https://docs.docker.com/engine/admin/pruning/

https://www.khs1994.com/docker/prune.html

# 使用本地私有 Docker 仓库

https://www.khs1994.com/docker/registry.html

# 容器日志

https://docs.docker.com/engine/admin/logging/view_container_logs/

```bash
$ docker logs CONTAINER_NAME

$ docker service logs SERVICE_NAME
```

## 日志驱动

# Swarm mode
