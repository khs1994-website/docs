---
title: 使用 Docker 安装 Gogs
date: 2016-05-04 13:00:00
updated:
comments: true
tags:
- Gogs
- Docker
categories:
- Git
---

使用 [Docker Compose](/docker/compose.html) 安装 [Gogs](https://github.com/gogits/gogs)。

GitHub：https://github.com/khs1994-docker/ci

<!--more-->

# docker-compose.yaml

编写 `docker-compose.yml` 文件

```yaml
version: '3'

services:
  gogs:
    image: gogs/gogs
    ports:
      - "22:22"
      - "10080:3000"
    volumes:
      - ./data:/data
      - ./app.prod.ini:/data/gogs/conf/app.ini
      - ./ssl:/data/ssl
    links:
      - mysql:mysql
  mysql:
    image: mysql
    env_file: .env
#    ports:
#      - "3306:3306"
    volumes:
      - ./var/lib/mysql:/var/lib/mysql
```

编写 `.env` 文件

```bash
MYSQL_ROOT_PASSWORD=mytest
```

# HTTPS

准备好 ssl 证书，上传到 `./ssl`，两个 ssl 文件分别改名（名字与下边 `app.prod.ini` 文件中的配置名字匹配）。

修改 `app.prod.ini` 文件，修改内容

```bash
[server]
PROTOCOL = https
ROOT_URL = https://git.xc725.wang
CERT_FILE = /data/ssl/cert.pem
KEY_FILE = /data/ssl/key.pem
```

使用如下命令启动容器

```bash
$ docker-compose up -d
```

## nginx 配置

```nginx
server {
    listen  80;
    server_name git.xc725.wang;
    return        301 https://$server_name$request_uri;
}

upstream git {
   server 127.0.0.1:10080;
}

server {
    listen       443 ssl http2;
    server_name  git.xc725.wang;
    ssl_certificate      conf.d/ssl/1_git.xc725.wang_bundle.crt;
    ssl_certificate_key  conf.d/ssl/2_git.xc725.wang.key;
    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;

    location / {
            proxy_pass https://git;
    }
}
```

访问网页，开始安装。

# 升级

```bash
$ docker pull gogs/gogs

$ docker-compose down

$ docker-compose up -d
```

# 相关链接

* https://github.com/gogits/docs/blob/master/zh-CN/intro/faqs.md  
* http://blog.hypriot.com/post/run-your-own-github-like-service-with-docker/
