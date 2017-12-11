---
title: iPXE 模式启动 CoreOS（简单、推荐使用）
date: 2017-08-03 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

`iPXE` 模式启动 `CoreOS` 方法比较简单，无需配置 `PXE` 所需的服务器，推荐大家使用。

<!--more-->

# 准备

## 下载 `ipxe.iso`

```bash
$ wget http://boot.ipxe.org/ipxe.iso
```

## 克隆示例配置

克隆示例配置文件并启动内网安装服务器。

GitHub：https://github.com/khs1994-docker/coreos

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/coreos

$ cd coreos

$ docker-compose up  # 默认监听 8080 端口
```

内网服务器详情请参见 [CoreOS 安装服务本地服务器 Docker 化](https://www.khs1994.com/docker/coreos/install-server.html)。

## 放入文件

在 http://alpha.release.core-os.net/amd64-usr/ 点击版本号或 `current` ，下载以下文件:

`coreos_production_pxe.vmlinuz`

`coreos_production_pxe_image.cpio.gz`

放入 `current` 文件夹中。

## `ipxe.html`

打开示例中的 `ipxe.html`，按实际修改 IP

```bash
#!ipxe

set base-url http://192.168.199.100:8080/current
kernel ${base-url}/coreos_production_pxe.vmlinuz initrd=coreos_production_pxe_image.cpio.gz coreos.first_boot=1 coreos.config.url=http://192.168.199.100:8080/pxe/pxe-config.ign console=tty0 console=ttyS0 coreos.autologin=tty1 coreos.autologin=ttyS0
initrd ${base-url}/coreos_production_pxe_image.cpio.gz
boot
```

## `pxe-ignition.yaml`

进入示例中的 `./pxe/` 目录，在 `./pxe/pxe-ignition.yaml` 中设置 SSH 公钥。

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

## `pxe-config.ign`

之后使用以下命令转换为 `pxe-config.ign`

```bash
$ ct-v0.5.0-x86_64-apple-darwin -in-file pxe-ignition.yaml  > pxe-config.ign
```

格式转换之后可以验证 `pxe-config.ign` https://coreos.com/validate/

# 启动虚拟机

虚拟机添加 `ipxe.iso` ISO 镜像之后启动。

在启动界面按下 `Ctrl+B` ，依次输入以下命令。

```bash
iPXE> dhcp
iPXE> chain http://192.168.199.100:8080/ipxe.html
```

# 登录

`IPXE` 方式启动的 CoreOS 默认没有密码，直接在本机登录。

```bash
$ ssh core@ip
```

# 安装

之后 [安装到硬盘](install-disk-new.html)。
