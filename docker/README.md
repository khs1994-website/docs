---
title: Linux 安装 Docker
date: 2016-05-01 13:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文介绍最新版本的 Docker CE 安装。

本文内容来自我参与维护的 [《Docker 从入门到实践》](https://github.com/yeasy/docker_practice/blob/master/install/) 项目。

<!--more-->

# CentOS 7

## 配置 REPO

Install yum-utils, which provides the yum-config-manager utility:

```bash
$ sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
```

```bash
# 官方源

# $ sudo yum-config-manager \
#     --add-repo \
#     https://download.docker.com/linux/centos/docker-ce.repo

# 国内源
$ sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

需要启用的版本，包含 `Stable` `Edge` `Test` (即稳定版、最新版、测试版)。

```bash
$ sudo yum-config-manager --enable docker-ce-edge

$ sudo yum-config-manager --enable docker-ce-test

$ sudo yum-config-manager --disable docker-ce-edge
```

### 安装

```bash
$ sudo yum install docker-ce

# 或者安装指定版本
# 列出可用版本

$ yum list docker-ce --showduplicates | sort -r

# 安装指定版本

$ sudo yum install docker-ce-<VERSION>

# 例如 $ sudo yum install docker-ce-17.06.1.ce
```

# Debian

```bash
$ sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# 官方源

# $ curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
#
# $ sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
#    $(lsb_release -cs) \
#    stable"

# 国内源

$ curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

$ sudo add-apt-repository \
   "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update

$ sudo apt-get install docker-ce

# 或者安装指定版本
# 查看可供安装版本

$ apt-cache madison docker-ce

$ sudo apt-get install docker-ce=<VERSION>

# 例如 $ sudo apt-get install docker-ce=17.09.0~ce-0~debian
```

# Ubuntu

```bash
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# 官方源

# $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# $ sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"

# 国内源

$ curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

$ sudo add-apt-repository \
   "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update

$ sudo apt-get install docker-ce

# 或者安装指定版本
# 查看可供安装版本

$ apt-cache madison docker-ce

$ sudo apt-get install docker-ce=<VERSION>

# 例如 $ sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu
```

# Linux 安装之后配置

```bash
$ sudo systemctl enable docker.service

$ sudo systemctl start docker

$ sudo groupadd docker

$ sudo usermod -aG docker $USER

# 重新登录用户，有图形界面的 Linux，重新登录之后下面命令执行失败的，请重启电脑。

$ docker run --rm hello-world
```

# 国内镜像加速

`/etc/docker/daemon.json`

```json
{
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ],
  "debug": true,
  "dns": [
    "114.114.114.114",
    "8.8.8.8"
  ],
  "experimental": true
}
```

# 卸载

`RedHat` 系

```bash
$ sudo yum remove docker-ce
```

`Debian` 系

```bash
$ sudo apt-get purge docker-ce
```

```bash
$ sudo rm -rf /var/lib/docker
```

# 工具

## Compose

> 一次运行多个容器

## Registry v2

> 私有仓库

## Machine

> Docker Machine 的产生简化了这一过程，让你可以使用一条命令在你的计算机、公有云平台以及私有数据中心创建及管理 Docker 主机。

# 相关链接

* https://github.com/docker

* https://github.com/moby

* https://mobyproject.org

* https://github.com/linuxkit

* https://docs.docker.com/engine/installation/linux/docker-ce/centos/

* https://yq.aliyun.com/articles/110806
