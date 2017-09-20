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

本文是对官方文档 [Booting with PXE](//coreos.com/os/docs/latest/booting-with-pxe.html) 的翻译与补充。

<!--more-->

# 安装配置 PXE 服务器

安装配置查看 [Linux 自动部署](/linux/server/pxe.html)

* `coreos_production_pxe.vmlinuz`
* `coreos_production_pxe_image.cpio.gz`  

将以上两文件上传到 `/var/lib/tftpboot`

## 准备文件

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
  append coreos.first_boot=1 coreos.config.url=https://example.com/pxe-config.ign
```

`pxe-ignition.yml`  

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

将 `pxe-ignition.yml` 转化为 `pxe-ignition.json` 并放入 Nginx 服务器。详情见 [使用 Ignition 配置工具硬盘安装 CoreOS 三节点集群](/docker/coreos/install-disk-new.html)

# 登录

```bash
$ ssh core@ip
```

之后 [安装到硬盘](install-disk-new.md) 或挂载磁盘作为数据磁盘使用。
