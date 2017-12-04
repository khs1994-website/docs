---
title: Docker 网络
date: 2017-10-14 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文介绍 Docker 网络。

官方文档：https://docs.docker.com/engine/userguide/networking/

<!--more-->

# 网络类型

## `bridge`

![](https://docs.docker.com/engine/tutorials/bridge1.png)

`桥接类型` 是创建容器时默认连接的网络类型，用的比较多，这里不再详细介绍。

## `host`

容器将不会虚拟出自己的网卡，配置自己的 IP 等，而是使用宿主机的 IP 和端口，容器可以和宿主机一样，使用宿主机的 `eth0` 实现和外界的通信。换言之容器的 IP 地址即为宿主机 eth0 的 IP 地址。

```bash
$ docker run -dit --network host nginx:alpine
```

现在访问 `主机 IP` 即可看到 nginx 默认页面。

## `none`

这样创建出来的容器完全没有网络。

```bash
$ docker run -it --rm nginx:alpine ip addr

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
5: eth0@if6: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 scope global eth0
       valid_lft forever preferred_lft forever
```

后边可以通过 `docker network connect bridge CONTAINER_ID` 来将没有设置网络的容器连接到一个网络。

## container:name or id

`--network="container:name or id`

通过此参数启动的容器，拥有与被连接的容器相同的网络。

# 创建网络

```bash
$ docker network create -d bridge [ --subnet 172.25.0.0/16 ] NETWORK_NAME
```

`-d` 指定网络驱动，默认为 `bridge`，在 `Swarm mode` 中也可以创建 `overlay` 类型的网络。

# 查看网络

```bash
$ docker network ls

NETWORK ID          NAME                DRIVER              SCOPE
369f1b30c236        bridge              bridge              local
991412261a72        host                host                local
269fb25e6d2d        none                null                local
```

## 查看网络详情

```bash
$ docker network inspect bridge
```

# 容器连接网络

可以固定容器 IP

```bash
$ docker run --network=NETWORK_NAME [ --ip=172.25.3.3 ] ...

$ docker run --network="container:id or name"

$ docker network connect NETWORK_NAME CONTAINER_NAME
```

# 断开网络

```bash
$ docker network disconnect NETWORK_NAME CONTAINER_NAME
```

# 移除网络

```bash
$ docker network rm NETWORK_NAME

$ docker network prune
```

# Swarm mode

```bash
$ docker network create \
    --driver overlay \
    --subnet 10.0.9.0/24 \
    NETWORK_NAME

$ docker service create \
    --replicas 2 \
    --network NETWORK_NAME \
    --name my-web \
    nginx    
```

## Overlay network

## ingress network

The ingress network is created automatically when you initialize or join a swarm.

## docker_gwbridge

The docker_gwbridge network is created automatically when you initialize or join a swarm.

# 设置代理

## 17.07+

`~/.config.json`

```json
{
  "proxies":
  {
    "default":
    {
      "httpProxy": "http://127.0.0.1:3001",
      "noProxy": "*.test.example.com,.example2.com"
    }
  }
}
```

## other

设置环境变量，请查看 [官方文档](https://docs.docker.com/engine/userguide/networking/#use-a-proxy-server-with-containers)
