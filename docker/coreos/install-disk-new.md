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

原理：以 `ISO` 或者 [`PXE`](/docker/coreos/boot-pxe-new.html) 或者 [`iPXE`](/docker/coreos/boot-ipxe.html) 模式启动 `CoreOS`，然后安装到硬盘。

<!--more-->

三个节点私有IP分别为：  

* 192.168.57.110
* 192.168.57.111
* 192.168.57.112

内网服务器搭建过程请查看 [CoreOS 安装服务 本地服务器配置](install-server.html)

# 准备所需文件

进入 http://alpha.release.core-os.net/amd64-usr/ 点击版本号或 `current` ，下载以下文件:

* `coreos_production_iso_image.iso`       # iso 启动文件

* `coreos_production_image.bin.bz2`       # 镜像文件

* `coreos_production_image.bin.bz2.sig`   # 签名文件

## 编辑 `ignition.yaml`

```yaml
passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - ssh-rsa AAAAB3Nza...
      create:
        groups:
          - sudo
          - docker
etcd:
  name:                        coreos3
  discovery: https://discovery.etcd.io/249ea9815631abc753fe4a4743f147d2
  advertise_client_urls:       http://192.168.57.102:2379
  initial_advertise_peer_urls: http://192.168.57.102:2380
  listen_client_urls:          http://192.168.57.102:2379,http://0.0.0.0:4001
  listen_peer_urls:            http://0.0.0.0:2380
systemd:
  units:
    - name: settimezone.service
      enable: true
      contents: |
        [Unit]
        Description=Set the time zone

        [Service]
        ExecStart=/usr/bin/timedatectl set-timezone  PRC
        RemainAfterExit=yes
        Type=oneshot
networkd:
   units:
     - name: 10-static.network
       contents: |
         [Match]
         Name=enp0s3

         [Network]
         Address=192.168.57.102/24
     - name: 20-dhcp.network
       contents: |
         [Match]
         Name=enp0s8

         [Network]
         DHCP=yes
storage:
  files:
    - filesystem: "root"
      path:       "/etc/hostname"
      mode:       0644
      contents:
        inline: coreos3
    - filesystem: "root"
      path:       "/etc/resolv.conf"
      mode:       0644
      contents:
        inline: |
          nameserver 114.114.114.114
    - filesystem: "root"
      path:       "/etc/hosts"
      mode:       0644
      contents:
        inline: |
          127.0.0.1	localhost
          ::1		localhost
          127.0.0.1 example.com
```
> 最新版文件请访问  
https://github.com/khs1994-website/docker-coreos/blob/master/ignition.yaml

> 该文件必须按实际情况进行修改，千万不要无脑复制，三个节点的文件主要修改以下几个配置
1. etcd2 中 https://discovery.etcd.io/new?size=3 申请 token，`192.168.57.110`改为每个节点的内网地址，三个节点使用同一 token
2. 每个节点设置不同的 静态 ip 、hostname
3. 配置好 SSH 公钥

由于本次模拟三个节点的集群，每个节点安装之前，都要提前修改好 `ignition.yaml`（包括 etcd 、 IP 、hostname 等）之后使用以下命令生成 `ignition.json`，也就是每个节点的`ignition.json`都是不同的，请提前配置好。

```bash
$ ct-v0.4.2-x86_64-apple-darwin -in-file ignition.yaml  > ignition.json
```

关于 Ignition 请查看 [CoreOS 配置工具 Ignition 简介](ignition.html)

> 格式转换之后验证 `ignition.json`
https://coreos.com/validate/

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
├── ignition.json
└── current -> /Users/khs1994/docker/www/coreos-disk/1506.0.0
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

## SSH 登录并安装

```bash
# 本机登陆

$ ssh core@192.168.57.110

$ wget http://192.168.57.1:8080/ignition.json

# 必须以 root 用户运行

$ sudo coreos-install -d /dev/sda -C alpha -V 1506.0.0 \
      -i ignition.json -v -b http://192.168.57.1:8080

# 执行成功后，关闭虚拟机      
```

> 安装脚本通过 `-i` 选项加载配置 `ignition.json`

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

三个节点全部安装之后，按以下方式依次启动虚拟机。  
去掉 `ISO` 启动选项，以磁盘方式启动虚拟机

## 删除内网路由

根据实际配置网络

```bash
$ ip route show
$ sudo ip route del default
```

# 更新记录

* 2017/8 : 配置工具使用新的 `Ignition`

# 相关链接

* https://yq.aliyun.com/articles/42288
* https://raw.githubusercontent.com/coreos/init/master/bin/coreos-install
