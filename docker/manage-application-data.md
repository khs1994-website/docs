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

* `bind`

* `volume`

* `tmpfs`

# source

`source` 或 `src`

# destination

`destination` 或 `dst` 或 `target`

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

官方文档：https://docs.docker.com/engine/admin/volumes/bind-mounts/

`-v` 参数挂载的文件或目录路径如果不存在，Docker 会默认创建一个文件夹

`--mount` 参数挂载的文件或目录路径如果不存在，Docker 不会自动创建，并且会报错

```bash
$ docker run \
   --mount type=bind,source=$PWD/app,target=/app \
   # -v "$(pwd)"/target:/app \
   --mount type=bind,source=$PWD/app,target=/app,readonly \
   # -v "$(pwd)"/target:/app:ro
```

## macOS

```bash
--mount type=bind,source=$PWD/target,destination=/app,consistency=cached
```

* `consistent` or `default`: The default setting with full consistency, as described above.

* `delegated`: The container runtime’s view of the mount is authoritative. There may be delays before updates made in a container are visible on the host.

* `cached`: The macOS host’s view of the mount is authoritative. There may be delays before updates made on the host are visible within a container.

These options are completely ignored on all host operating systems except `macOS`.

# tmpfs

```bash
--mount type=tmpfs,destination=/app

--mount type=tmpfs,destination=/app,tmpfs-mode=1770
```
