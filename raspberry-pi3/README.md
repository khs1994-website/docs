---
title: 树莓派3 常用设置
date: 2017-04-02 13:00:00
updated:
comments: true
tags:
- Raspberry Pi3
categories:
- Raspberry Pi3
---

# SSH登录

TF卡`boot`新建一个名为`ssh`的空白文件。

官方的 Raspbian 系统默认的登录帐号： `pi` ，密码： `raspberry`

<!--more-->

# 常用配置

## 换源

```bash
$ sudo vi /etc/apt/source.list
```

用#注释存在的内容

```
deb http://mirrors.aliyun.com/raspbian/raspbian/ jessie main contrib non-free rpi
deb-src http://mirrors.aliyun.com/raspbian/raspbian/ jessie main contrib non-free rpi
```

## 改时区

```bash
$ dpkg-reconfigure tzdata
```

# 网络配置

## DNS

```bash
$ vi /etc/resolvconf.conf

# configure your subscribers configuration files below.
name_servers=127.0.0.1
```

## 静态IP

```bash
$ vim /etc/dhcpcd.conf

interface eth0

static ip_address=192.168.0.10/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1

interface wlan0

static ip_address=192.168.0.200/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1

#！！！修改  /etc/network/interfaces 的方法已经过时

```
# Shell

## Fish Shell

下载编译安装    https://github.com/fish-shell/fish-shell

```bash
$ autoreconf --no-recursive [if building from Git]
$ ./configure
$ make [gmake on BSD]
$ sudo make install
```
# 软件

## Samba

http://shumeipai.nxez.com/2013/08/24/install-nas-on-raspberrypi.html

## Nginx、PHP、Python

# 相关链接

* http://www.cnblogs.com/taojintianxia/p/6026225.html
