---
title: PXE Linux 自动部署
date: 2016-08-08 13:00:00
updated:
comments: true
tags:
- Linux
- PXE
categories:
- Linux
- Server
---

Linux 自动部署需要以下软件 `PXE` `dhcp` `tftp` `vsftpd` `kickstart`。

<!--more-->

服务器 IP 192.168.57.101  

# 安装软件

```bash
$ yum install tftp-server dhcp syslinux vsftpd xinetd
```

## DHCP

修改 `/etc/dhcp/dhcpd.conf` 文件

```bash
allow booting;
allow bootp;
ddns-update-style interim;
ignore client-updates ;
subnet 192.168.57.0 netmask 255.255.255.0 {
    option routers                  192.168.57.1;
    option subnet-mask              255.255.255.0;
    range dynamic-bootp 192.168.57.101 192.168.57.200;
    default-lease-time 21600;
    max-lease-time 43200;
    next-server 192.168.57.101;
    #注意改地址
    filename "pxelinux.0";
}     
```

## TFTP

### 配置xinetd

将 `/etc/xinetd.d/tftp` 中的 `disable` 值设为 no

## syslinux

# 挂载安装光盘

在 root 家目录新建 `cdrom` 文件夹，挂载光盘

```bash
$ mkdir cdrom
$ mount /dev/cdrom cdrom
```

# 复制引导文件

```bash
$ cd /var/lib/tftpboot
$ cp /usr/share/syslinux/pxelinux.0 .
$ cp ~/cdrom/images/pxeboot/{initrd.img,vmlinuz} .
$ cp ~/cdrom/isolinux/{vesamenu.c32,*.msg} .
$ mkdir pxelinux.cfg
$ cp ~/cdrom/isolinux/isolinux.cfg pxelinux.cfg/default
```

编辑 `pxelinux.cfg/default` 文件。

```bash
#第1行

default linux
#第64行

append initrd=initrd.img inst.stage2=ftp://192.168.57.101 ks=ftp://192.168.57.101/pub/ks.cfg quiet

#第70行

append initrd=initrd.img inst.stage2=ftp://192.168.57.101 rd.live.check ks=ftp://192.168.57.101/pub/ks.cfg quiet
```

# VSFTP

## 复制光盘镜像内容到ftp目录

```bash
$ cp -r ~/cdrom/* /var/ftp
```

# kickstart

```bash
$ cp ~/anaconda-ks.cfg /var/ftp/pub/ks.cfg
$ chmod +r /var/ftp/pub/ks.fg
```

修改 `/var/ftp/pub/ks.cfg` 文件

```bash
#第6行

url --url=ftp://192.168.57.101

#第21行

timezone Asia/Shanghai --isUtc

#第28行

clearpart --all -initlabel
```

# 开机自启动服务

```bash
$ systemctl enable dhcpd
$ systemctl enable vsftpd
$ systemctl enable xinetd
```

# 客户端

设置网卡为第一启动项
