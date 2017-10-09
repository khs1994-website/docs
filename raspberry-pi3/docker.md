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

`arm32v7` `arm64v8` 架构 Docker 全解析。

<!--more-->

配置方法和 Linux 一样，由于和 `x86_64` 架构不同,不同之处仅是安装包、拉取 Docker 镜像的差别，配置加速器等操作和其他无异，跟多内容请查看本博客 Docker[https://www.khs1994.com/categories/Docker/] 分类下的文章。

# arm32v7

即运行官方的 `Raspbian Stretch Lite(基于 Debian 9)`

```bash
$ uname -a

Linux raspberrypi 4.12.3-v7 #1 SMP Mon Jul 24 10:40:40 CST 2017 armv7l GNU/Linux
```

直接添加如下源即可安装 Docker

```bash
deb [arch=armhf] http://mirrors.aliyun.com/docker-ce/linux/debian stretch test
```

```bash
$ sudo apt install docker-ce
```

请 pull [arm32v7](https://hub.docker.com/u/arm32v7/) 镜像

# arm64v8

暂时没有64位的官方系统，使用 [pi64](https://www.khs1994.com/raspberry-pi3/arm64v8.html)

安装 Ubuntu arm64 版本的 Docker。

国内镜像：http://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/dists/xenial/pool/test/arm64/

官方地址：https://download.docker.com/linux/ubuntu/dists/xenial/pool/test/arm64/

wget 下载该包

```bash
$ sudo dpkg -i docker*

# 安装依赖软件

$ sudo apt install -f -y

$ sudo usermod -aG docker $USER

# 设置字符集

$ sudo localectl set-locale LANG=en_US.UTF-8
$ sudo localectl set-keymap LANG=en_US.UTF-8
$ sudo localectl set-x11-keymap LANG=en_US.UTF-8
```
请 pull [arm64v8](https://hub.docker.com/u/arm64v8/) 镜像

# 其他操作系统

## Rancher OS 64位

GitHub：https://github.com/rancher/os

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

GitHub：https://github.com/hypriot/image-builder-rpi

# More Information

* http://dockone.io/article/1676
