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

# 修订说明

* 务必弃用 `-v` 参数，为了方便对比，本文以注释方式提供 `-v` 参数示例。

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

不创建也可以，使用时若不存在，Docker 会自动新建。

```bash
$ docker volume create VOLUME_NAME

$ docker volume ls

# 删除

$ docker volume rm VOLUME_NAME
```

## `$ docker run`

type=`volume`，可以省略，默认为该类型。

```bash
$ docker run \
   --mount type=volume,src=VOLUME_NAME,target=/app
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

将数据卷挂载为只读文件夹。

```
--mount source=nginx-vol,destination=/usr/share/nginx/html,readonly

# 进入容器，尝试新建文件夹，会提示错误

$ mkdir: can't create directory 'a.txt': Read-only file system
```

# bind mounts

官方文档：https://docs.docker.com/engine/admin/volumes/bind-mounts/

`-v` 参数挂载的文件或目录路径如果不存在，Docker 会默认创建一个文件夹。

`--mount` 参数挂载的文件或目录路径如果不存在，Docker 不会自动创建，并且会报错。

`type` 为 `bind`

```bash
$ docker run \
   --mount type=bind,src=$PWD/app,target=/app \
   # -v "$(pwd)"/target:/app \
   --mount type=bind,source=$PWD/app,target=/app,readonly \
   # -v "$(pwd)"/target:/app:ro
```

## macOS

该选项仅用于 `macOS`

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

`tmpfs` 没有宿主机源文件。

# 注意事项

当挂载一个 `空的数据卷` 时，若挂载的容器目标目录存在文件时，Docker 会把容器中的文件复制到数据卷中。若 `监听主机目录` 或 `挂载非空数据卷` 时，不会复制容器中原有文件，而是由原路径文件直接覆盖容器中的目标路径。下面通过具体的命令来进行说明。

```bash
$ docker run -it --rm \
    --mount src=new_vol,target=/etc/nginx/conf.d \
    nginx:alpine \
    ls /etc/nginx/conf.d
default.conf

# 以上说明 Docker 复制容器中的原有文件到了这个空的数据卷

# 在数据卷写入数据

$ docker run -it --rm \
    --mount src=new_vol,target=/etc/nginx/conf.d \
    nginx:alpine \
    sh

/ # cd /etc/nginx/conf.d/
/etc/nginx/conf.d # rm -rf *
/etc/nginx/conf.d # ls
/etc/nginx/conf.d # touch test.txt

# 退出，现在数据卷 new_vol 非空，下面测试挂载一个非空数据卷，看会不会复制容器中的文件到数据卷。

$ docker run -it --rm \
    --mount src=new_vol,target=/etc/nginx/conf.d \
    nginx:alpine \
    ls /etc/nginx/conf.d
test.txt

# 以上说明没有复制

# 现在测试一下监听主机目录

$ docker run -it --rm \
    --mount type=bind,src=$PWD,target=/etc/nginx/conf.d \
    nginx:alpine \
    ls /etc/nginx/conf.d

# 没有看到 default.conf
# 说明没有复制容器中的原有文件，主机中的文件直接覆盖掉了容器中的原有文件    
```
