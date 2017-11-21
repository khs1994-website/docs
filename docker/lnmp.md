---
title: LNMP Docker 安装配置
date: 2016-05-05 13:00:00
updated:
comments: true
tags:
- LNMP
- Docker
categories:
- Docker
---

目标：一条命令建立 LNMP 环境（MySQL、Redis、PHP-fpm、Nginx，etc）。这里只简单列举单容器运行方式，实际请使用 `Docker Compose`。

GitHub：https://github.com/khs1994-docker/lnmp-quickstart

GitHub：https://github.com/khs1994-docker/lnmp

<!--more-->

# 修订说明

* 官方建议不再使用 `--link`，而是使用 Docker 容器网络来连接容器(服务，也即容器互通)。

* 官方建议不再使用 `-v` 或者 `--volume`，而是使用 `--mount` `Docker 17.06+`

# 准备

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/lnmp-quickstart

$ cd lnmp-quickstart
```

# 创建网络

```bash
$ docker network ls

$ docker network create -d bridge lnmp
```

# 创建 Volume

```bash
$ docker volume ls

$ docker volume create lnmp-mysql-data
```

# MySQL

```bash
$ docker run -dit \
   --net lnmp \
   --name mysql \
   -p 3306:3306 \
   -e MYSQL_ROOT_PASSWORD=mytest \
   # -v lnmp-mysql-data:/var/lib/mysql \
   --mount source=lnmp-mysql-data,target=/var/lib/mysql \
   mysql
```

## 参数

### 只允许本地用户登录

`$ docker run -p` 命令改为以下格式

```bash
$ –p 127.0.0.1:3306:3306
```

# Redis

```bash
$ docker run -dit \
    --net lnmp \
    --name redis \
    -p 6379:6379 \
    redis:alpine
```

# PHP7

`php-fpm` 官方镜像需要通过 `Dockerfile` 增加 PHP 扩展

## 增加扩展

编辑 `Dockerfile` 增加 PHP 扩展

```docker
FROM php:fpm

RUN docker-php-ext-install pdo_mysql

RUN pecl install redis \
    && docker-php-ext-enable redis
```

注意: 安装其他扩展可能需要其他依赖包，请使用 `RUN apk add --no-cache PACKAGE_NAME` 安装依赖。

## 构建镜像

```bash
$ docker build -t username/php:fpm .
```

## 运行容器

```bash
$ docker run -dit \
    --net lnmp \
    --name php7 \
    # -v $PWD/app:/app \
    --mount type=bind,source=$PWD/app,target=/app,readonly \
    username/php:fpm
```

# Nginx

```bash
$ docker run -dit \
    --net lnmp \
    -p 80:80 \
    -p 443:443 \
    --name nginx \
    # -v $PWD/app:/app \
    --mount type=bind,source=$PWD/app,target=/app,readonly \
    # -v $PWD/conf.d:/etc/nginx/conf.d \
    --mount type=bind,source=$PWD/conf.d,target=/etc/nginx/conf.d,readonly \
    nginx:alpine
```

# 测试 LNMP

```bash
$ docker ps -a

CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                                      NAMES
e77477b89a65        nginx:alpine        "nginx -g 'daemon of…"   3 seconds ago        Up 4 seconds        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx
e74dda1abdb8        username/php:fpm    "docker-php-entrypoi…"   25 seconds ago       Up 26 seconds       9000/tcp                                   php7
55eb02c94a3a        redis:alpine        "docker-entrypoint.s…"   46 seconds ago       Up 47 seconds       0.0.0.0:6379->6379/tcp                     redis
314d54410929        mysql               "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp                     mysql
```

访问 `127.0.0.1` 看到 php info 页面。

访问 `127.0.0.1/redis.php` 测试 PHP redis 扩展。

```bash
$ docker exec -it mysql mysql -uroot -pmytest

mysql> create database test;
Query OK, 1 row affected (0.00 sec)
```

访问 `127.0.0.1/pdo-mysql.php` 测试 PHP pdo_mysql 扩展。

# docker-compose

请访问 [khs1994-docker/lnmp](https://github.com/khs1994-docker/lnmp) 查看。
