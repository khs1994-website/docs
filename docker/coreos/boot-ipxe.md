---
title: iPXE 模式启动 CoreOS（简单、推荐使用）
date: 2017-08-04 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

iPXE 模式启动 CoreOS 方法比较简单，无需配置 PXE 所需的服务器，推荐大家使用。

<!--more-->

# 准备

下载 `ipxe.iso`

```bash
$ wget http://boot.ipxe.org/ipxe.iso
```

准备好以下文件

coreos_production_pxe.vmlinuz

coreos_production_pxe_image.cpio.gz

内网服务器搭建过程请查看 [CoreOS 安装服务 本地服务器配置](install-server.html)  

## `ipxe.html`

```bash
#!ipxe

set base-url http://192.168.199.100/current
kernel ${base-url}/coreos_production_pxe.vmlinuz initrd=coreos_production_pxe_image.cpio.gz coreos.first_boot=1 coreos.config.url=http://192.168.199.100/pxe-ignition.json console=tty0 console=ttyS0 coreos.autologin=tty1 coreos.autologin=ttyS0
initrd ${base-url}/coreos_production_pxe_image.cpio.gz
boot
```

## `pxe-ignition.yaml`

```yaml
systemd:
  units:
    - name: etcd2.service
      enable: true

passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - ssh-rsa AAAA...
```

之后使用以下命令生成 `pxe-ignition.json`

```bash
$ ct-v0.4.2-x86_64-apple-darwin -in-file ignition.yaml  > ignition.json
```

关于 Ignition 请查看 [CoreOS 配置工具 Ignition 简介](ignition/README.html)

> 格式转换之后验证 `ignition.json`
https://coreos.com/validate/

## 服务器文件结构

```
.
├── 1506.0.0
│   ├── coreos_production_image.bin.bz2
│   ├── coreos_production_image.bin.bz2.sig
│   ├── coreos_production_pxe.vmlinuz
│   ├── coreos_production_pxe_image.cpio.gz
│   └── version.txt
├── current -> /Users/khs1994/atom/www/local/home/1506.0.0
├── ignition.json
├── ignition.yaml
├── ipxe.html
├── pxe-ignition.json
└── pxe-ignition.yaml
```

# 启动

添加 `ipxe.iso` 启动虚拟机。  
在启动界面按下 Ctrl+B ，依次输入以下命令

```bash
iPXE> dhcp
iPXE> chain http://192.168.199.100/ipxe.html
```

# 登录

```bash
$ ssh core@ip
```

# 安装

之后 [安装到磁盘](install-disk-new.html)。
