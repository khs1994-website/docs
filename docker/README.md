---
title: CentOS7 安装 Docker
date: 2016-08-05 13:00:00
updated: 2016-06-12 12:00:00
comments: true
tags:
- Docker
categories:
- Docker
---

# 安装

## 配置REPO

>Install yum-utils, which provides the yum-config-manager utility:

```bash
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

<!--more-->

>Use the following command to set up the stable repository:

### 官方镜像

访问慢，请使用国内镜像

```bash
$ sudo yum-config-manager  \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```
### 国内镜像

```bash
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

>You can disable the edge repository by running the yum-config-manager command with the --disable flag. To re-enable it, use the --enable flag.

```bash
$ sudo yum-config-manager --enable docker-ce-edge

$ sudo yum-config-manager --enable docker-ce-test

$ sudo yum-config-manager --disable docker-ce-edge
```

## 安装

```bash

$ sudo yum install docker-ce

# 或者指定版本号

$ sudo yum install docker-ce-<VERSION>

# Configure Docker to start on boot

$ sudo systemctl enable docker.service

# Start the Docker daemon.

$ sudo systemctl start docker

# Create the docker group.

$ sudo groupadd docker

# Add your user to docker group.

$ sudo usermod -aG docker $USER

# Log out and log back in.
# This ensures your user is running with the correct permissions.Verify that your user is in the docker group by running docker without sudo.  

$ docker run --rm hello-world
```

## 国内镜像加速

```bash
$ vi /lib/systemd/system/docker.service

ExecStart=/usr/bin/dockerd --registry-mirror=https://wcafmbzt.mirror.aliyuncs.com

#在`ExecStart=/usr/bin/dockerd`之后加上如上所示内容
```

# 创建Docker网络

```bash
$ docker network create --subnet=192.168.0.0/24 test
$ docker network connect test web（容器名）
$ docker network disconnect test web（容器名）
$ docker run -it --network=test --ip 192.168.0.100 centos
```

# 卸载

```bash
$ sudo yum remove docker-ce
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
