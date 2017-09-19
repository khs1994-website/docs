---
title: 硬盘安装 CoreOS 三节点集群 （已废弃）
date: 2016-08-10 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
- Deprecated
categories:
- Docker
- CoreOS
---

本文所述安装方法已经过时，不再更新。请查看 [使用 Ignition 配置工具硬盘安装 CoreOS 三节点集群](/docker/coreos/install-disk-new.html)

<!--more-->

三个节点私有IP分别为：  

* 192.168.57.110
* 192.168.57.111
* 192.168.57.112

内网服务器搭建过程请查看 [CoreOS 安装服务 本地服务器配置](install-server.html)

原理：以 `ISO` 或者 `PXE` 或者 `iPXE` 模式启动 `CoreOS`，然后安装到硬盘。

# 准备所需文件

进入 http://alpha.release.core-os.net/amd64-usr/ 点击版本号或 `current` ，下载以下文件:

* `coreos_production_iso_image.iso`       # iso 启动文件

* `coreos_production_image.bin.bz2`       # 镜像文件

* `coreos_production_image.bin.bz2.sig`   # 签名文件

## 编辑`cloud-config.yaml`（已废弃）

```yaml
#cloud-config

hostname: coreos1

coreos:
  etcd2:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
    discovery: https://discovery.etcd.io/<token>
    # multi-region and multi-cloud deployments need to use $public_ipv4
    advertise-client-urls: http://192.168.57.110:2379
    initial-advertise-peer-urls: http://192.168.57.110:2380
    # listen on both the official ports and the legacy ports
    # legacy ports can be omitted if your application doesn't depend on them
    listen-client-urls: http://0.0.0.0:2379,http://0.0.0.0:4001
    listen-peer-urls: http://192.168.57.110:2380,http://192.168.57.110:7001
  units:
    - name: settimezone.service
      command: start
      content: |
        [Unit]
        Description=Set the time zone

        [Service]
        ExecStart=/usr/bin/timedatectl set-timezone  PRC
        RemainAfterExit=yes
        Type=oneshot
    - name: etcd2.service
      command: start
    - name: 10-static.network
      content: |
        [Match]
        Name=enp0s3

        [Network]
        Address=192.168.57.110/24
    - name: 20-dhcp.network
      content: |
        [Match]
        Name=enp0s8

        [Network]
        DNS=114.114.114.114
        DHCP=yes
users:
  - name: core
    ssh-authorized-keys:
      - ssh-rsa AAAAB3...
  - groups:
      - sudo
      - docker
```

> 该文件必须按实际情况进行修改，千万不要无脑复制
1. etcd2 中 https://discovery.etcd.io/new?size=3 申请 token，`192.168.57.110` 改为内网地址
2. 每个节点设置不同的 静态 ip
3. 配置好 SSH 公钥

> 验证该文件  
https://coreos.com/validate/

> `cloud-config.yaml`配置详细说明  
https://coreos.com/os/docs/latest/cloud-config.html  

>最新版文件请访问  
https://github.com/khs1994-website/docker-coreos/blob/master/cloud-config.yaml

由于本次模拟三个节点的集群，每个节点安装之前，都要提前修改好 `cloud-config.yaml`（包括 etcd 、 IP 、hostname 等），也就是每个节点的 `cloud-config.yaml` 都是不同的，请提前配置好。

# 本地服务器文件结构

参照 http://alpha.release.core-os.net/amd64-usr/ 结构

将 `current` 软链接到版本号

```bash
$ cd /Users/khs1994/docker/www/coreos-disk
$ ln -s $PWD/1506.0.0 current
$ tree

.
├── 1506.0.0
│   ├── coreos_production_image.bin.bz2
│   └── coreos_production_image.bin.bz2.sig
│   └── version.txt
├── cloud-config.yaml
└── current -> current -> /Users/khs1994/docker/www/coreos-disk/1506.0.0
```

>参考资料中作者通过改 `coreos-install` 文件指定本地服务器，我发现安装时可以通过 `-b` 参数指定本地服务器，这样就做到了尽量最少改动，完成安装。  
屏幕会显示出详细的信息，如果出错根据提示信息进行排查

# 安装 CoreOS

启动添加了 ISO 镜像的虚拟机，添加两块网卡，选择加载 `coreos_production_iso_image.iso` 镜像，启动。或是以 `PXE` `iPXE` 模式启动虚拟机。

```bash
# 查看 IP 以便后边登录

$ ip addr

# 若是以 ISO 启动虚拟机需要改密码(虚拟机里输入命令不方便,本机ssh登录操作)

$ sudo passwd core
```

# SSH 登录和安装

```bash
# 本机登陆

$ ssh core@192.168.57.110

$ wget http://192.168.57.102:8080/cloud-config.yaml

# 必须以 root 用户运行

$ sudo coreos-install -d /dev/sda -C alpha -V 1506.0.0 \
      -c cloud-config.yaml -v -b http://192.168.57.102:8080

# 执行成功后，关闭虚拟机      
```

> 安装脚本通过 `-c` 选项加载云端配置 `cloud-config.yaml` 并写入磁盘。会被安装到 `/var/lib/coreos-install/user_data` 并在每次启动时加载。

## 参数说明

```bash
Usage: ./coreos-install [-C channel] -d /dev/device
Options:
    -d DEVICE   Install Container Linux to the given device.
    -V VERSION  Version to install (e.g. current) [default: current]
    -B BOARD    Container Linux board to use [default: amd64-usr]
    -C CHANNEL  Release channel to use (e.g. beta) [default: stable]
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

去掉 `ISO` 启动选项，启动虚拟机

# 删除内网路由

根据实际配置网络

```bash
$ ip route show
$ sudo ip route del default
```

# 更新记录

* 2017/8 ：上次很难解决的网络问题，也没出现（双网卡，一个 `host-only` 访问虚拟机内部网络，一个`桥接`访问外网）
* 2017/8 : `coreos-install` 是系统自带命令，不用下载了
* 2017/8 : `cloud-config.yaml` 已经废弃，使用新的 Ignition

# 相关链接

* https://yq.aliyun.com/articles/42288
* https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install
