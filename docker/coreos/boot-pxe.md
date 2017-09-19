---
title: PXE 模式启动 CoreOS (已废弃)
date: 2016-06-03 13:00:00
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

本文所述安装方法已经过时，不再更新。请查看 [使用 Ignition 配置工具 PXE 模式安装 CoreOS](/docker/coreos/boot-pxe-new.html)

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
  append cloud-config-url=http://192.168.57.102:8080/pxe-cloud-config.yml
```

`pxe-cloud-config.yml`  

```yaml
#cloud-config

coreos:
  units:
    - name: etcd2.service
      command: start
    - name: fleet.service
      command: start
ssh_authorized_keys:
    - ssh-rsa AAAAB3NzaC1y..
```

将 `pxe-cloud-config.yml` 文件放入 Nginx 服务器。详情见 [硬盘安装 CoreOS （已废弃）](install-disk.html) 一文

# 登录

```bash
$ ssh core@ip
```

之后安装到硬盘或挂载磁盘作为数据磁盘使用。
