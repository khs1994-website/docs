---
title: DNS 服务器配置
date: 2016-08-06 13:00:00
updated:
comments: true
tags:
- Linux
- DNS
categories:
- Linux
- Server
---

DNS（Domain Name System，域名系统），因特网上作为域名和 IP 地址相互映射的一个分布式数据库，能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的 IP 数串。

<!--more-->

# 安装

```bash
$ yum install bind bind-chroot
```

# 修改主配置文件

编辑 `/etc/named.conf` 文件

```bash
...
listen-on port 53 { any; };
...
allow-query     { any; };
```

# 增加域名

编辑 `/etc/named.rfc1912.zones` 文件

```bash
#增加以下内容

zone "tkhs1994.com" In {
    type master;
    file "tkhs1994.com.zone";
    allow-update { none; };
};
```

## 配置文件

编辑 `/var/named/tkhs1994.com.zone` 文件。

```bash
$TTL 7200
@ IN SOA @ khs1994.tkhs1994.com. (222 1H 15M 1W 1D)
@ IN NS dns1.tkhs1994.com.
dns1 IN A 192.168.56.200
* IN A 127.0.0.1
```
