---
title: Docker Machine 使用详解
date: 2017-06-01 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Automate container provisioning on your network or in the cloud. Available for Windows, macOS, or Linux.

GitHub: https://github.com/docker/machine

<!--more-->

命名为 `default`

# 创建

使用官方支持的 `virtualbox` 驱动。

```bash
$ docker-machine create \
      --driver virtualbox \
      --engine-opt dns=114.114.114.114 \
      --engine-registry-mirror https://registry.docker-cn.com \
      --virtualbox-memory 2048 \
      --virtualbox-cpu-count 2 \
      default
```

## macOS xhyve

使用第三方驱动 `xhyve`

GitHub: https://github.com/zchee/docker-machine-driver-xhyve

```bash
$ brew install docker-machine-driver-xhyve

$ docker-machine create \
      -d xhyve \
      # 不指定这一项的话，每次启动都会从 github 下载 iso
      --xhyve-boot2docker-url ~/.docker/machine/cache/boot2docker.iso \
      --engine-opt dns=114.114.114.114 \
      --engine-registry-mirror https://registry.docker-cn.com \
      --xhyve-memory-size 2048 \
      --xhyve-rawdisk \
      --xhyve-cpu-count 2 \
      xhyve
```

# 列出

```bash
$ docker-machine ls

NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
default   -        virtualbox   Running   tcp://192.168.99.100:2376           v17.10.0-ce
xhyve     -        xhyve        Running   tcp://192.168.64.2:2376             v17.10.0-ce
```

# 进入

```bash
$ docker-machine env default
$ eval "$(docker-machine env default)"
$ docker run -d -p 8000:80 nginx
$ curl $(docker-machine ip default):8000

# 如果此时想操作本地的 Docker ,先退出终端重新打开一个新的终端。
```

## 通过 SSH 进入

```bash
$ docker-machine ssh default

$ docker@default:~$ docker info
```
