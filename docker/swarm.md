---
title: Docker Swarm mode 详解
date: 2017-08-07 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

使用 `docker swarm` Dcoker 内置的集群管理的工具，Docker CE `1.12+`。注意与旧的 `Docker Swarm` 区分开来。

OS: CoreOS 1562.1.0 3个节点

OS: macOS + Docker Machine

<!--more-->

Docker Swarm 在 Docker 1.12 版本之前属于一个独立的项目，在 Docker 1.12 版本发布之后，该项目合并到了 Docker 中，成为 Docker 的一个子命令 `docker swarm`。

有关集群的 Docker 命令如下：

`docker swarm`：集群管理，子命令有 init, join, join-token, leave, update

`docker node`：节点管理，子命令有 demote, inspect, ls, promote, rm, ps, update

`docker service`：服务管理，子命令有 create, inspect, ps, ls ,rm , scale, update

`docker stack/deploy`：用于多应用部署 `docker stack deploy ...`

# 创建

## 使用 Docker Machine 创建集群

`khs1994.com` 备注：`docker-machine create --swarm` 等 `--swarm*` 是旧的 `Docker Swarm`，与本文提到的 `Swarm mode` 没有关系。

Docker Machine：https://www.khs1994.com/docker/machine.html

官方文档：https://docs.docker.com/machine/reference/create/#specifying-docker-swarm-options-for-the-created-machine

```bash
$ docker-machine create \
      -d virtualbox \
      --engine-registry-mirror https://registry.docker-cn.com \
      swarm1
```

```bash
$ docker-machine create \
      -d virtualbox \
      --engine-registry-mirror https://registry.docker-cn.com \
      swarm2
```

```bash
$ docker-machine create \
      -d virtualbox \
      --engine-registry-mirror https://registry.docker-cn.com \
      swarm3
```

使用 `docker-machine ssh MACHINE_NAME` 通过 SSH 登录到机器。

## CoreOS 集群

创建一个 CoreOS 3 节点集群：https://www.khs1994.com/docker/coreos/install-disk-new.html

# 初始化集群

在其中一个节点执行

```bash
$ docker swarm init --advertise-addr 192.168.99.104
```

如果机器有多个网卡，请使用 `--advertise-addr` 参数指定 IP

之后执行

```bash
$ docker swarm join-token [OPTIONS] (worker|manager)
```

按照提示在另外两个节点执行命令加入集群。

# 查看节点

只能在管理节点使用此命令

```bash
$ docker node ls

ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
1iukw9dq9ltg2qfich77yk31x *   swarm1              Ready               Active              Leader
3a63ymhnbh07vy54jnmn9j3ra     swarm2              Ready               Active
rvqgt0vsl3grhxlr0jdf2gnur     swarm3              Ready               Active
```

# 创建服务

```bash
$ docker service create --replicas 2 --name nginx nginx:alpine
```

## 查看服务状态

```bash
$ docker service ls
```

## 查看服务详情

```bash
$ docker service ps nginx
```

# 负载均衡

```bash
$ docker service create --replicas 2 --name nginx -p 7080:80 nginx:alpine
```

## 查看服务状态

```bash
$ docker service ps nginx

ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
jqo9c9h3x0kz        nginx.1             nginx:alpine        coreos2             Running             Running 8 seconds ago
dbcy4z9jpj6k        nginx.2             nginx:alpine        coreos1             Running             Running 8 seconds ago
```

## 退出一个节点

```bash
$ docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
6jxbotcy3q7y        nginx.1             nginx:alpine        coreos3             Running             Running 2 seconds ago
jqo9c9h3x0kz         \_ nginx.1         nginx:alpine        coreos2             Shutdown            Complete 3 minutes ago
dbcy4z9jpj6k        nginx.2             nginx:alpine        coreos1             Running             Running 3 minutes ago
```

`coreos2` 节点关机之后，原来空闲的 `coreos3` 节点自动启动了一个容器。

## 减少实例数量

```bash
$ docker service scale nginx=2
```

# docker stack

```bash
$ docker stack deploy -c docker-stack.yml lnmp

$ docker stack ls

$ docker stack ps lnmp

$ docker stack services lnmp

$ docker stack rm lnmp
```

# More Information

* http://www.jianshu.com/p/9eb9995884a5
