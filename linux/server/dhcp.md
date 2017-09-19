---
title: DHCP 服务器配置
date: 2016-08-06 13:00:00
updated:
comments: true
tags:
- Linux
- DHCP
categories:
- Linux
- Server
---

DHCP（Dynamic Host Configuration Protocol，动态主机配置协议）是一个局域网的网络协议，使用UDP协议工作，给内部网络或网络服务供应商自动分配IP地址。

<!--more-->

```bash
$ yum install dhcp
$ cp /usr/share/doc/dhcp-4.2.5/dhcpd.conf.example /etc/dhcp/dhcpd.conf
$ vi /etc/dhcp/dhcpd.conf

subnet 192.168.3.0 netmask 255.255.255.0 {
range 192.168.3.10 192.168.3.254;
option routers 192.168.3.1;
option broadcast-address 192.168.3.31;
default-lease-time 3600;
max-lease-time 7200;
#指向pxe服务器
next-server 192.168.3.10;
filename "pxelinux.0";
}

$ systemctl start dhcpd.service
```

**查看一些资料时的配置选项可能会在新版删除，使用`dhcpd`启动若有错误会有详细说明**
