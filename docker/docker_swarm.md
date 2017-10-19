---
title: Docker Swarm 详解
date: 2017-08-07 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

使用 `$ docker swarm` 这一 Dcoker 内置的集群管理的工具。

OS: CoreOS 1562.1.0

Docker: v17.09.0

<!--more-->

Docker Swarm 在 Docker 1.12 版本之前属于一个独立的项目，在 Docker 1.12 版本发布之后，该项目合并到了 Docker 中，成为 Docker 的一个子命令 `$ docker swarm`。

有关集群的 Docker 命令如下：

docker swarm：集群管理，子命令有 init, join, join-token, leave, update
docker node：节点管理，子命令有 demote, inspect, ls, promote, rm, ps, update
docker service：服务管理，子命令有 create, inspect, ps, ls ,rm , scale, update
docker stack/deploy：试验特性，用于多应用部署

# 初始化集群

创建一个 3 节点集群。

```bash
$ docker swarm init
```

如果机器有多个网卡，请使用 `--advertise-addr` 参数指定 IP

之后执行

$ docker swarm join-token [OPTIONS] (worker|manager)

按照提示将另外两个节点加入集群。

# 查看节点

只能在管理节点使用此命令

```bash
$ docker node ls
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

# More Information

* http://www.jianshu.com/p/9eb9995884a5
