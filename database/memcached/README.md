---
title: Memcached 安装配置
date: 2017-07-26 17:00:00
updated:
comments: true
tags:
- Memcached
categories:
- DataBase
- Memcached
---

# 安装 Memcached

官方网站：http://memcached.org/

下载，解压，进入文件夹

<!--more-->

```bash
$ sudo apt install libsasl2-dev libevent-dev

$ ./configure --prefix=/data/usr/local/memcached --enable-sasl

$ make

$ make install  
```

## 安装 libmemcached

官方网站：http://libmemcached.org/libMemcached.html

```bash
$ ./configure --prefix=/data/usr/local/libmemcached
$ make
$ make install
```
