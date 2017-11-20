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

# 断开网络

```bash
$ docker network disconnect bridge CONTAINER_NAME
```

# 创建网络

```bash
$ docker network create -d bridge --subnet 172.25.0.0/16 NETWORK_NAME
```

# 查看网络

```bash
$ docker network ls
```

# 容器连接网络

```bash
$ docker run --net=NETWORK_NAME --ip=172.25.3.3 ...
```

```bash
$ docker network connect NETWORK_NAME CONTAINER_NAME
```

# Docker Swarm

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
