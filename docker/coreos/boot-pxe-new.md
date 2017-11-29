---
title: PXE 模式启动 CoreOS
date: 2017-08-02 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

本文是对 `CoreOS` 官方文档 [Booting with PXE](//coreos.com/os/docs/latest/booting-with-pxe.html) 的翻译与补充。

<!--more-->

# 安装配置 PXE 服务器

安装配置 `PXE` 服务器请查看本博客文章 [Linux 自动部署](/linux/server/pxe.html)。

# 准备文件

进入 http://alpha.release.core-os.net/amd64-usr/ 点击版本号或 `current` ，下载以下文件:

`coreos_production_pxe.vmlinuz`

`coreos_production_pxe_image.cpio.gz`

# PXE 服务器配置详情

将以上两文件上传到 `PXE` 服务器的 `/var/lib/tftpboot` 目录下。并在 `PXE` 服务器中执行以下操作

```bash
$ cp /usr/share/syslinux/pxelinux.0 .
$ mkdir /var/lib/tftpboot/pxelinux.cfg
$ vi /var/lib/tftpboot/pxelinux.cfg/default

default coreos
prompt 1
timeout 15

label coreos
menu default
  kernel coreos_production_pxe.vmlinuz
  initrd coreos_production_pxe_image.cpio.gz
  append coreos.first_boot=1 coreos.config.url=https://192.168.199.100:8080/pxe/pxe-config.ign
```

# 克隆示例配置

克隆示例配置文件并启动内网安装服务器。

GitHub：https://github.com/khs1994-docker/coreos

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/coreos

$ cd coreos

$ docker-compose up  # 默认监听 8080 端口
```

内网服务器详情请参见 [CoreOS 安装服务本地服务器 Docker 化](https://www.khs1994.com/docker/coreos/install-server.html)。

### `pxe-ignition.yaml`

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
        - ssh-rsa AAAAB3N
```

### `pxe-ignition.json`

将 `pxe-ignition.yaml` 转化为 `pxe-ignition.ign`。

```bash
$ ct-v0.5.0-x86_64-apple-darwin -in-file pxe-ignition.yaml  > pxe-ignition.ign
```

# 启动虚拟机

`VirtualBox` 使用 `PXE` 启动，必须安装扩展包。

# 登录

在本机登录

```bash
$ ssh core@ip
```

之后 [安装到硬盘](install-disk-new.md) 或挂载磁盘作为数据磁盘使用。
