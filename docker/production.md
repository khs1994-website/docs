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

# 自动启动容器

https://docs.docker.com/engine/admin/start-containers-automatically/

```bash
$ docker run --restart no | on-failure | unless-stopped | always
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

# Keep containers alive during daemon downtime

https://docs.docker.com/engine/admin/live-restore/

# systemd

https://docs.docker.com/engine/admin/systemd/

# 使用本地私有 Docker 仓库

https://www.khs1994.com/docker/registry.html

# 容器日志

https://docs.docker.com/engine/admin/logging/view_container_logs/

```bash
$ docker logs CONTAINER_NAME

$ docker service logs SERVICE_NAME
```

## 日志驱动

# 安全

https://docs.docker.com/engine/security/security/

# Swarm mode

## 服务创建

* `docker service create ...` 一个服务

* `docker stack deploy ...` 多个服务

## 服务详情

```bash
$ docker service ls ps inspect logs

$ docker stack ps STACK_NAME

$ docker stack services STACK_NAME
```

## 存储配置数据

https://docs.docker.com/engine/swarm/configs/

`docker config` 命令

以 `redis` 为例

```bash
$ echo "This is a config" | docker config create my-config -

# 配置文件默认挂载到 /my-config ，也可以通过 target 进行配置

$ docker service  create \
    --name redis \
    # --config my-config \
    --config source=my-config,target=/config/path \
    redis:alpine

$ docker config ls

# 当配置文件被使用时，不能删除

$ docker config rm my-config
```

## 存储敏感数据

https://docs.docker.com/engine/swarm/secrets/

`docker secret` 命令

以 `nginx` 为例

```bash
$ docker secret create site.key site.key

$ docker secret create site.crt site.crt

$ docker secret create site.conf site.conf

$ docker secret ls

# 默认挂载到 /run/secrets/*** ，你可以通过 target 配置

$ docker service create \
     --name nginx \
     --secret site.key \
     --secret site.crt \
     --secret source=site.conf,target=/etc/nginx/conf.d/site.conf \
     --publish target=3000,port=443 \
     nginx:latest \
     sh -c "exec nginx -g 'daemon off;'"
```

## 服务更新

https://docs.docker.com/edge/engine/reference/commandline/service_update/

```bash
$ docker service update ...
```

## 服务回退

https://docs.docker.com/edge/engine/reference/commandline/service_rollback/#related-commands

```bash
$ docker service rollback
```

## 删除服务

```bash
$ docker service rm ...

$ docker stack rm ...
```

## 服务容器数量伸缩

```bash
$ docker service scale backend=3 frontend=5
```

## 跨节点数据管理

讨论 https://github.com/khs1994-docker/lnmp/issues/275

* NFS

* https://github.com/vieux/docker-volume-sshfs

* ceph

## 网络

讨论 https://github.com/khs1994-docker/lnmp/issues/279

# 在一个容器中运行多个服务

https://docs.docker.com/engine/admin/multi-service_container/
