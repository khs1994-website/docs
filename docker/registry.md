---
title: Docker 私有仓库安装配置 (Registry v2)
date: 2017-08-05 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

使用 Docker Compose + Docker machine 配置一个 Docker 私有仓库。

GitHub：https://github.com/khs1994-docker/registry

官方 GitHub：https://github.com/docker/distribution/releases

<!--more-->

一种是使用 Docker Compose

一种是基于 `registry` 镜像 ，添加配置文件之后构建自己的镜像。具体查看 [GitHub](https://github.com/khs1994-docker/registry)

# 准备

申请 SSL 证书放到 ssl 文件夹，这里不进行详细说明。

编辑 `config.yml`，该文件详细配置讲解请查看 [Docker Registry v2 配置文件详解]()

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
  host: https://docker.xc725.wang
  headers:
    X-Content-Type-Options: [nosniff]
  http2:
    disabled: false
  tls:
    certificate: /etc/docker/registry/ssl/docker.xc725.wang.crt
    key: /etc/docker/registry/ssl/docker.xc725.wang.key
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
```

## 添加登陆用户

将以下命令中的 `username` `password` 替换为 `用户名` 和 `密码` ，也可以添加多个用户更多内容请搜索 `htpasswd`

```bash
$ docker run --rm \
    --entrypoint htpasswd \
    registry \
    # 部分 nginx 可能不能解密，你可以替换为下面的命令
    # -mbn username password > auth/nginx.htpasswd \
    -Bbn username password > auth/nginx.htpasswd
```

## 编辑 `docker-compose.yml`

```yaml
version: '3'

services:
  registry:
    image: registry
#    restart: always
    ports:
      - "443:443"
      # - "5000:443"
    volumes:
      - ./:/etc/docker/registry
      - registry-data:/var/lib/registry
    depends_on:
      # - nginx  

volumes:
  registry-data:      
```

# 启动

## Swarm mode

由于 `Docker Machine` 不包含 Compose，这里使用 `Swarm mode`。

```bash
$ docker-machine create \
      --driver virtualbox \
      --engine-opt dns=114.114.114.114 \
      --engine-registry-mirror https://registry.docker-cn.com \
      --virtualbox-memory 2048 \
      --virtualbox-cpu-count 2 \
      registry

$ docker-machine ip registry

$ docker-machine ssh registry

$ docker swarm init --advertise-addr=192.168.99.100

$ git clone --depth=1 https://github.com/khs1994-docker/registry.git

$ cd registry

# 修改配置之后

$ docker stack deploy -c docker-compose.yml registry
```

## 自定义镜像并运行

配置好所需文件，构建镜像，运行容器

```bash
$ docker build -t username/registry .

$ docker run -dit \
    --mount src=registry-data,target=/var/lib/registry \
    -p 443:443 \
    username/registry
```

## Docker Compose

```bash
$ docker-compose up -d
```

# Nginx 代理配置

https://docs.docker.com/registry/recipes/nginx/

若使用外部 Nginx，在 `docker-compose.yml` 将端口配置为 `5000:443`。

```nginx
upstream docker-registry {
    # 修改 IP
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
    # 修改域名
    server_name docker.xc725.wang;

    # SSL
    # 修改 SSL 路径
    ssl_certificate conf.d/ssl/docker.xc725.wang.crt;
    ssl_certificate_key conf.d/ssl/docker.xc725.wang.key;

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

# 测试私有仓库功能

修改 `/etc/hosts`，替换为对应 IP

```bash
127.0.0.1 docker.xc725.wang
```

## 网页查看

https://docker.xc725.wang/v2/_catalog

## 命令行登录

```bash
$ docker login docker.xc725.wang
#接下来输入用户名、密码
```

## 命令行操作

```bash
$ docker pull nginx:alpine
$ docker tag nginx docker.khs1994.com/nginx:alpine
$ docker push docker.khs1994.com/nginx:alpine
$ docker rm docker.xc725.wang/nginx:alpine
$ docker pull docker.c725.wang/nginx:alpine
```

# 命令参考

```bash
$ docker exec {docker-registry id} registry [command]
```

## 垃圾回收

https://docs.docker.com/registry/garbage-collection/

```bash
$ docker exec -it {docker-registry id} \
    bin/registry garbage-collect [--dry-run] /etc/docker/registry/config.yml
```

## 搜索

参考 API：https://docs.docker.com/registry/spec/api/

## 查看版本

```bash
$ docker exec {docker-registry id} registry --version

registry github.com/docker/distribution v2.6.0
```

## 帮助信息

```bash
$ docker exec [docker-registry id] registry help
```

# 相关链接

* [官方文档](https://docs.docker.com/registry/)

* [Dockerfile](https://github.com/docker/distribution-library-image)

* [Nginx 代理](https://docs.docker.com/registry/recipes/nginx/)

* http://www.jb51.net/os/other/369064.html

* http://www.tuicool.com/articles/fAbiYnN
