---
title: Ubuntu 初始化配置
date: 2016-08-06 13:00:00
updated:
comments: true
tags:
- Linux
- Ubuntu
categories:
- Linux
---

# 网络配置

## 静态IP

```bash
$ sudo vi  /etc/network/interface

...
# The primary network interface
auto enp0s3
iface enp0s3 inet dhcp

auto enp0s8
iface enp0s8 inet static
address 192.168.56.130
netmask 255.255.255.0
```

<!--more-->

## 网络超时

```bash
$ cd /etc/systemd/system/network-online.target.wants
$ sudo vi networking.service
```

## DNS

# 常用软件

```bash
$ sudo apt install gcc g++ \
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
