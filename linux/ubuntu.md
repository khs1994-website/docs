---
title: Ubuntu 初始化配置
date: 2016-08-05 13:00:00
updated:
comments: true
tags:
- Linux
- Ubuntu
categories:
- Linux
---

本文简要介绍了 Ubuntu 常用配置。

<!--more-->

# 网络配置

## 静态IP


编辑 `/etc/network/interface` 文件。

```bash
# The primary network interface
auto enp0s3
iface enp0s3 inet dhcp

auto enp0s8
iface enp0s8 inet static
address 192.168.56.130
netmask 255.255.255.0
```

## DNS

编辑 `/etc/resolvconf.conf` 文件

```bash
# configure your subscribers configuration files below.
name_servers=127.0.0.1
```

# 常用软件

```bash
$ sudo apt install gcc g++
```

## mail

```bash
$ apt install mailutils
```

## openssl

```bash
$ sudo apt install openssl
$ sudo apt install libssl-dev
```

## update-alternatives

* http://persevere.iteye.com/blog/1479524
