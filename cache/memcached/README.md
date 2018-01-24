---
title: Memcached 安装配置
date: 2016-04-13 17:00:00
updated:
comments: true
tags:
- Memcached
categories:
- Cache
- Memcached
---

官方网站：http://memcached.org/

<!--more-->

# 安装

下载，解压，进入文件夹

```bash
$ sudo apt install libsasl2-dev libevent-dev

$ ./configure --prefix=/usr/local/memcached --enable-sasl

$ make

$ make install  
```

# 服务端启动

```bash
$ memcached -d -l 127.0.0.1 -p 11211 -m 1024 -u root
```

# 客户端安装

## 安装 libmemcached

### 使用包管理工具安装

Debian 系

```bash
$ apt install libmemcached-dev
```

RedHat 系

```bash
$ yum install libmemcached-devel
```

### 编译安装

官方网站：http://libmemcached.org/libMemcached.html

```bash
$ ./configure --prefix=/usr/local/libmemcached

$ make

$ make install
```

## 各种语言的扩展

这里不再列举。
