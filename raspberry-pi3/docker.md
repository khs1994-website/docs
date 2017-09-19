---
title: 树莓派 3 Docker 详解
date: 2017-09-16 13:00:00
updated:
comments: true
tags:
- Raspberry Pi3
- Docker
categories:
- Raspberry Pi3
---

`arm32v7` `arm64v8` 架构 Docker 全解析

<!--more-->

# arm32v7

即运行官方的 `Raspbian Stretch Lite(Debian 9)`

```bash
$ uname -a

Linux raspberrypi 4.12.3-v7 #1 SMP Mon Jul 24 10:40:40 CST 2017 armv7l GNU/Linux
```

直接添加如下源即可安装 Docker

```
deb [arch=armhf] http://mirrors.aliyun.com/docker-ce/linux/debian stretch test
```

请 pull [arm32v7](https://hub.docker.com/u/arm32v7/) 镜像

# arm64v8

# 其他操作系统

## Rancher OS 64位

在 https://github.com/rancher/os/releases 下载 `rancheros-raspberry-pi64.zip` ，刷入 TF 卡。

### SSH

```bash
$ ssh rancher@ip

# 密码为 rancher

$ uname -a

Linux rancher.lan 4.9.34-bee42-v8 #1 SMP PREEMPT Mon Jun 26 01:51:13 UTC 2017 aarch64 GNU/Linux
```

### 切换 Docker 版本

```bash
$ sudo ros engine list

disabled docker-1.12.6
disabled docker-1.13.1
enabled  docker-17.03.1-ce
disabled docker-17.03.2-ce
disabled docker-17.04.0-ce
disabled docker-17.05.0-ce
disabled docker-17.06.1-ce

# 切换指定版本
$ sudo ros engine switch docker-17.05.0-ce
```

## HypriotOS

# 参考链接

* http://dockone.io/article/1676
