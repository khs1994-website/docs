---
title: 硬盘安装 CoreOS 三节点集群
date: 2017-08-01 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---


本例在 `VirtualBox` 虚拟机，以 `ISO` 或者 [`PXE`](boot-pxe-new.html) 或者 [`iPXE`](boot-ipxe.html) 模式启动 `CoreOS`，然后安装到硬盘。

<!--more-->

# 更新记录

* 2017/12：默认启用 [Docker Daemon TLS 远程连接](https://www.khs194.com/docker/dockerd.html)。

* 2017/8：CoreOS 配置工具使用新的 [`Ignition`](../ignition/README.html) 代替 `cloud-config`，旧的安装方法已经删除，但 GitHub 仍保留该配置文件。

# 设置网卡模式

`VirtualBox` 虚拟机网络设置如下

| 网卡    | 模式                  | IP              |
| :----- | :-------------        |:------         |
| 网卡1   | `host-only` (`DHCP`)  | `192.168.57.*` |
| 网卡2   | 桥接 (`DHCP`)          | `192.168.199.*` |

本例中三个节点 IP 分别为：

* 192.168.57.110

* 192.168.57.111

* 192.168.57.112

> VirtualBox 可以新建该网段，如果你的节点不是以上 IP 请按照 https://www.khs194.com/docker/dockerd.html 提供的方法，生成证书。

# 准备文件

进入 http://alpha.release.core-os.net/amd64-usr/ 点击版本号或 `current` ，下载以下文件:

iso 启动文件 `coreos_production_iso_image.iso`

镜像文件 `coreos_production_image.bin.bz2`

签名文件 `coreos_production_image.bin.bz2.sig`

## 克隆示例配置文件

GitHub：https://github.com/khs1994-docker/coreos

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/coreos

$ cd coreos
```

## 修改 `.env` 文件中的变量值

各项变量含义都已经注明，按实际修改即可

## 放入文件

把 `coreos_production_image.bin.bz2` `coreos_production_image.bin.bz2.sig` 放入 `current` 文件夹中。

## 启动容器

```bash
$ docker-compose up
```

# 安装 CoreOS

## 启动

> 虚拟机内存最低设置为 `2G`，否则将不能使用！

新建虚拟机，添加按照文章开头设置两块网卡，选择加载 `coreos_production_iso_image.iso` ISO 镜像之后启动。

> ISO 启动方式不支持 UEFI

```bash
# 查看 IP 以便后边登录

$ ip addr

# 需要改密码 虚拟机里输入命令不方便,本机 ssh 登录操作

$ sudo passwd core
```

## SSH 登录并安装

本机登陆

```bash
$ ssh core@IP

$ wget http://192.168.57.1:8080/disk/ignition-1.json

# 必须以 root 用户运行，安装脚本通过 `-i` 选项加载配置文件 `ignition.json`

$ sudo coreos-install \
      -d /dev/sda \
      -C alpha \
      # -V 1590.0.0 \
      -i ignition-1.json \
      -b http://192.168.57.1:8080 \
      -v

+ echo 'Success! CoreOS Container Linux alpha 1590.0.0 is installed on /dev/sda'
Success! CoreOS Container Linux alpha 1590.0.0 is installed on /dev/sda

# 执行成功后，关闭虚拟机

$ sudo shutdown now  
```

关闭虚拟机之后移除 `ISO`，在虚拟机设置 `系统` 里选择 `启用 EFI`。稍后启动，接下来在其他两个节点进行安装。

## 在另外两个节点安装

重复上边两步，注意每次 `wget` 所下载的文件是不同的，`coreos-install` 命令 `-i` 参数后边跟着 `wget` 所下载的文件。

```bash
$ ssh core@IP

$ wget http://192.168.57.1:8080/disk/ignition-2.json

# $ wget http://192.168.57.1:8080/disk/ignition-3.json

$ sudo coreos-install -d /dev/sda -C alpha \
      -i ignition-2.json -v -b http://192.168.57.1:8080

# $ sudo coreos-install -d /dev/sda -C alpha \
#       -i ignition-3.json -v -b http://192.168.57.1:8080  
```

## 参数说明

```bash
$ coreos-install -h

Usage: /usr/bin/coreos-install [-C channel] -d /dev/device
Options:
    -d DEVICE   Install Container Linux to the given device.
    -V VERSION  Version to install (e.g. current) [default: 1590.0.0]
    -B BOARD    Container Linux board to use [default: amd64-usr]
    -C CHANNEL  Release channel to use (e.g. beta) [default: alpha]
    -o OEM      OEM type to install (e.g. ami) [default: (none)]
    -c CLOUD    Insert a cloud-init config to be executed on boot.
    -i IGNITION Insert an Ignition config to be executed on boot.
    -b BASEURL  URL to the image mirror (overrides BOARD)
    -k KEYFILE  Override default GPG key for verifying image signature
    -f IMAGE    Install unverified local image file to disk instead of fetching
    -n          Copy generated network units to the root partition.
    -v          Super verbose, for debugging.
    -h          This ;-)

This tool installs CoreOS Container Linux on a block device. If you PXE booted
Container Linux on a machine then use this tool to make a permanent install.  
```

# 启动

三个节点全部安装之后，依次启动虚拟机。

# SSH 登录

```bash
$ ssh core@192.168.57.110

Last login: Wed Nov 29 11:52:26 UTC 2017 from 192.168.57.1 on pts/0
Container Linux by CoreOS alpha (1590.0.0)
core@coreos1 ~ $ docker --version
Docker version 17.10.0-ce, build afdb6d4
```

# 网络配置

## 删除内网路由

根据实际配置网络

```bash
$ ip route show
$ sudo ip route del default
```

# 相关链接

* https://yq.aliyun.com/articles/42288

* https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install
