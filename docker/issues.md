---
title: Docker 实践遇到的问题（持续更新）
date: 2017-09-05 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文列举了一些本人在使用 Docker 过程中遇到的问题。

<!--more-->

# 时区

```docker
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
```

基于 `Debian` 的镜像通过设置环境变量改变时区

```bash
$ TZ=Asia/Shanghai
```

基于 `Alpine` 的镜像先安装 `tzdate`，再设置环境变量

```docker
RUN apk add --no-cache tzdata
```

# 交叉运行

https://github.com/justincormack/cross-docker

`x86_64` 架构运行其他架构（ armhf 等）容器，原理是运用 `QEMU`。

macOS 不用以上脚本，实际测试中与树莓派对比，性能较差，毕竟是虚拟机。

# 网络

## macOS

macOS 不能 ping 通容器（Linux docker0 默认为 172.17.0.1），所以容器想要 ping 主机，必须填写路由器分配给主机的 IP（192.168.199.100，而不是 172.17.0.1）。

## DNS、host

不能在文件中写入配置，写入也不生效。在 `daemon.json` 中可以配置 DNS , host 请通过 `docker build` 、`docker run` 时的命令参数进行设置。

# 使用 Docker Compose

本博客系列文章运行容器方式由 `docker run` 转变为 [`docker-compose`](compose.html)。

# 规范

## 一个容器，一个服务

比如不要在一个容器中安装 LNMP，可以使用 Docker Compose 分配到 3 个容器，集中启动、管理。

# 命令

使用 `docker image` 管理镜像 代替 `docker images`

使用 `docker container` 管理容器 代替 `docker ps`

使用 `docker volume` 管理数据卷

使用 `docker network` 管理容器网络

# 参考链接

* http://dockone.io/question/362
