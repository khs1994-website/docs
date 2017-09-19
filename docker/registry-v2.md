---
title: Docker 私有仓库(Registry) v2 安装配置
date: 2017-08-05 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

服务器位于本机，如果本机已占用 443 端口，请配置 Nginx 代理，如果未占用，请直接启动容器。

首先介绍的是直接启动容器。

<!--more-->

# 准备

本次根目录为 `/Users/khs1994/docker/data/registry` ,当所有文件准备好之后，scp 到虚拟机

GitHub:https://github.com/khs1994-website/docker-registry-conf

## SSL证书

从腾讯云申请免费的 SSL 证书之后下载，得到文件 `docker.khs1994.com.zip` 将解压之后的 `Nginx` 文件夹下两个文件复制到 `/Users/khs1994/docker/data/registry/ssl`

## 编辑config.yml

`config.yml`

```yaml
version: 0.1
log:
  accesslog:
    disabled: true
  level: debug
  formatter: text
  fields:
    service: registry
    environment: staging
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
auth:
  htpasswd:
    realm: basic-realm
    path: /etc/docker/registry/auth/nginx.htpasswd
http:
  addr: :443
  host: https://docker.khs1994.com
  headers:
    X-Content-Type-Options: [nosniff]
  http2:
    disabled: false
  tls:
    certificate: /etc/docker/registry/ssl/1_docker.khs1994.com_bundle.crt
    key: /etc/docker/registry/ssl/2_docker.khs1994.com.key
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
```

## 添加登陆用户

将以下命令中的 `username` `password` 替换为 `用户名` 和 `密码` ，也可以添加多个用户更多内容请搜索 `htpasswd`

```bash
$ docker run --rm --entrypoint htpasswd \
    registry:2 -Bbn username password > auth/nginx.htpasswd
```

# 启动 registry 容器

编辑 `docker-compose.yml`

```yaml
version: '3'

services:
  registry:
    image: registry
#    restart: always
    ports:
      - "443:443"
    volumes:
      - ./:/etc/docker/registry
      - ./var/lib/registry:/var/lib/registry
```

使用以下命令启动关闭容器

```bash
$ docker-compose up -d
# 关闭
$ docker-compose stop
```

若异常退出，请运行下面命令排查错误

```bash
$ docker logs registry
```

# 客户机操作

我已在域名解析处把 `docker.xc725.wang` 解析到了 `本机 IP`, 还可以通过修改本地 /etc/hosts 文件将 `docker.khs1994.com` 解析到 `127.0.0.1`，这里请根据实际情况修改。

## 测试私有仓库功能

网页查看 https://docker.xc725.wang/v2/_catalog

```bash
# 登录
$ docker login docker.xc725.wang #接下来输入用户名、密码

# 使用

$ docker pull nginx
$ docker tag nginx docker.khs1994.com/nginx
$ docker push docker.khs1994.com/nginx
```

# Nginx 代理配置

若 443 端口已占用，请配置 Nginx 代理。

请自行查找学习 Nginx 配置，请将 SSL 证书路径、IP 等变量确定好。示例配置如下：

```nginx
upstream docker-registry {
    server 127.0.0.1:5000;
}

  ## Set a variable to help us decide if we need to add the
  ## 'Docker-Distribution-Api-Version' header.
  ## The registry always sets this header.
  ## In the case of nginx performing auth, the header will be unset
  ## since nginx is auth-ing before proxying.
map $upstream_http_docker_distribution_api_version $docker_distribution_api_version {
    '' 'registry/2.0';
}

server {
    listen 443 ssl;
    server_name docker.xc725.wang;

    # SSL
    ssl_certificate conf.d/ssl/1_docker.xc725.wang_bundle.crt;
    ssl_certificate_key conf.d/ssl/2_docker.xc725.wang.key;

    # Recommendations from https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
    ssl_protocols TLSv1.1 TLSv1.2;
    ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:1m;

    # disable any limits to avoid HTTP 413 for large image uploads
    client_max_body_size 0;

    # required to avoid HTTP 411: see Issue #1486 (https://github.com/moby/moby/issues/1486)
    chunked_transfer_encoding on;

    location /v2/ {
      # Do not allow connections from docker 1.5 and earlier
      # docker pre-1.6.0 did not properly set the user agent on ping, catch "Go *" user agents
      if ($http_user_agent ~ "^(docker\/1\.(3|4|5(?!\.[0-9]-dev))|Go ).*$" ) {
        return 404;
      }

      # To add basic authentication to v2 use auth_basic setting.
      # nginx not support bcrypt.
      auth_basic "Registry realm";
      auth_basic_user_file conf.d/auth/nginx.htpasswd;

      ## If $docker_distribution_api_version is empty, the header will not be added.
      ## See the map directive above where this variable is defined.
      add_header 'Docker-Distribution-Api-Version' $docker_distribution_api_version always;

      proxy_pass                          http://docker-registry;
      proxy_set_header  Host              $http_host;   # required for docker client's sake
      proxy_set_header  X-Real-IP         $remote_addr; # pass on real client's IP
      proxy_set_header  X-Forwarded-For   $proxy_add_x_forwarded_for;
      proxy_set_header  X-Forwarded-Proto $scheme;
      proxy_read_timeout                  900;
    }
}
```

使用以下命令启动容器：

```yaml
$ docker run -dit \
    -p 127.0.0.1:5000:5000 \
    -v `pwd`/var/lib/registry:/var/lib/registry
    registry
```

# 命令参考

```bash
$ docker exec [docker-registry id] registry [command]
```

## 垃圾回收

## 搜索

## 常用命令

* 查看版本

```bash
$ docker exec [docker-registry id] registry --version

registry github.com/docker/distribution v2.6.0
```

* 帮助

```bash
$ docker exec [docker-registry id] registry help

`registry`

Usage:
  registry [flags]
  registry [command]

Available Commands:
  serve           `serve` stores and distributes Docker images
  garbage-collect `garbage-collect` deletes layers not referenced by any manifests
  help            Help about any command

Flags:
  -h, --help=false: help for registry
  -v, --version=false: show the version and exit


Use "registry help [command]" for more information about a command.
```

# 相关链接

* http://www.jb51.net/os/other/369064.html  
* 官方文档: https://docs.docker.com/registry/  
* GitHub： https://github.com/docker/distribution/releases
* Dockerfile: https://github.com/docker/distribution-library-image
* Nginx 代理：https://docs.docker.com/registry/recipes/nginx/
