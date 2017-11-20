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

GitHub：https://github.com/khs1994-docker/lnmp

<!--more-->

# MySQL

```bash
$ docker run -d \
   --name mysql001 \
   -p 3306:3306 \
   -e MYSQL_ROOT_PASSWORD=mytest \
   -v /Users/khs1994/docker/var/lib/mysql:/var/lib/mysql \
   mysql
```

## 参数

### 只允许本地用户登录

docker run -p 命令改为以下格式。

```bash
$ –p 127.0.0.1:3306:3306
```

# Redis

```bash
$ docker run -dit \
    --name redis001 \
    -p 6379:6379 \
    redis:alpine
```

# PHP7

`php-fpm` 官方镜像需要通过 `Dockerfile` 增加 PHP 扩展

## 增加扩展

编辑 Dockerfile 增加 PHP 扩展

```docker
FROM php:fpm
RUN docker-php-ext-install pdo_mysql
RUN pecl install redis \
    && pecl install xdebug \
    && docker-php-ext-enable redis xdebug
```

## 构建镜像

```bash
$ docker build -t php-mysql .
```

## 运行容器

```bash
$ docker run -d \
    --name php7 \
    --link mysql001:mysql \
    --link redis001:redis \
    -v /Users/khs1994/docker/var/www:/var/www \
    php
```

# Nginx

```bash
$ docker run -d \
    -p 80:80 \
    -p 443:443 \
    --name nginx \
    --link php7:php \
    --link mysql001:mysql \
    --link redis001:redis \
    -v /Users/khs1994/docker/var/www:/var/www \
    -v /Users/khs1994/docker/etc/nginx/conf.d:/etc/nginx/conf.d \
    nginx
```

# docker-compose

请访问 [khs1994-docker/lnmp](https://github.com/khs1994-docker/lnmp) 查看。
