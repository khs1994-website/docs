---
title: CoreOS 安装服务 本地服务器配置
date: 2017-08-13 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

由于网络问题，避免外网下载镜像占用时间。安装过程中的所需文件全部放到自己搭建的内网服务器。本博客系列文章节点全部基于 `virtualbox` 虚拟机。  

网卡设置如下：

* 网卡1 `hostonly` 模式       192.168.57.*        # 静态IP
* 网卡2 `桥接`      模式       192.168.199.*       # DHCP

<!--more-->

# 本地服务器配置

IP `192.168.57.1` 位于本机，由于此服务器承载了多项服务，通过指定不同端口号，提供多种服务，本次服务指定端口号 `8080`

## 启动 Nginx

```bash
$ docker run -dit -p 80:80 -p 443:443 -p 8080:8080 \
   --name coreos-server \
   -v /Users/khs1994/docker/var/www:/var/www \
   -v /Users/khs1994/docker/etc/nginx/conf.d:/etc/nginx/conf.d \
   nginx
```

## 配置  

进入 `/Users/khs1994/docker/nginx/conf.d/`，编写 `coreos-disk-8080.conf`

```nginx
server {
    listen       8080;
    server_name  localhost;
    autoindex on;
    autoindex_exact_size off;
    autoindex_localtime on;
    charset utf-8;
    location / {
        root   /var/www/coreos-disk;
        index  index.html index.htm index.php;
    }
}
```

# Docker 一键启动

以上服务器我已经打包成 [Docker 镜像](https://github.com/khs1994-website/docker-coreos)。
