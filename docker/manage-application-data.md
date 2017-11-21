---
title: Docker 数据管理
date: 2017-10-15 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

我们已经熟悉了 `-v` 或者 `--volume`，官方最近建议( Docker 17.06+ ) 使用 `--mount`。

官方文档：https://docs.docker.com/engine/admin/volumes/

<!--more-->

![](https://docs.docker.com/engine/admin/volumes/images/types-of-mounts-volume.png)

# 类型

`bind`

`volume`

`tmpfs`

# volumes

## 创建 volume

```bash
$ docker volume create VOLUME_NAME

$ docker volume ls

$ docker volume rm VOLUME_NAME
```

## `$ docker run`

```bash
$ docker run \
   --mount source=VOLUME_NAME,target=/app
   # -v VOLUME_NAME:/app \
   --mount source=nginx-vol,destination=/usr/share/nginx/html,readonly
   # -v nginx-vol:/usr/share/nginx/html:ro
```

## `$ docker service`

```bash
$ docker service create -d \
  --replicas=4 \
  --name SERVICE_NAME \
  --mount source=VOLUME_NAME,target=/app \
  nginx:latest
```

## readonly

```bash
$ mkdir: can't create directory 'a.txt': Read-only file system
```

# bind mounts

```bash
$ docker run \
   --mount type=bind,source=$PWD/app,target=/app \
   # -v "$(pwd)"/target:/app \
   --mount type=bind,source=$PWD/app,target=/app,readonly \
   # -v "$(pwd)"/target:/app:ro
```

## macOS

```bash
--mount type=bind,source="$(pwd)"/target,destination=/app,consistency=cached
```

# tmpfs

```bash
--mount type=tmpfs,destination=/app

--mount type=tmpfs,destination=/app,tmpfs-mode=1770
```
