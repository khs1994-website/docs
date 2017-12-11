---
title: Docker Compose version 3 使用详解
date: 2017-08-04 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Define application stacks built using multiple containers, services, and swarm configurations.

GitHub: https://github.com/docker/compose

<!--more-->

# install

Docker CE for Windows 10 、Docker CE for Mac 自带 `docker-compose`，官方建议随 Docker 版本升级。

Linux 请在 [GitHub releases](https://github.com/docker/compose/releases) 处下载二进制文件，移入 `PATH` 并赋予可执行权限。

或者执行以下命令进行下载安装。

```bash
$ DOCKER_COMPOSE_VERSION=1.17.1
$ curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
$ chmod +x docker-compose
$ sudo mv docker-compose /usr/local/bin
$ docker-compose --version
```

或者通过 `Python` 包管理工具 `pip` 安装。

## Command-line completion

### fish

`~/.config/fish/completions`

```bash
$ wget https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish
```

### bash

官方文档：https://docs.docker.com/compose/completion/

# Compose file reference

## build

```yaml
version: '3'
services:
  webapp:
    build:
      # Dockerfile 目录或 git 仓库网址
      context: ./dir | .
      # 3.2
      cache_from:
        - alpine:latest
        - corp/web_app:3.14
      # 3.3  
      labels:
        com.example.description: "Accounting webapp"
        com.example.department: "Finance"
        com.example.label-with-empty-value: ""  
      # Dockerfile 文件名称
      dockerfile: Dockerfile-alternate
      # 构建时变量，相当于 docker build --build-arg list
      args:
        buildno: 1
      args:
        - buildno=1
    image: webapp:tag
```

`Dockerfile` 中包含变量

```docker
ARG buildno
ARG password

RUN echo "Build number: $buildno"
RUN script-requiring-password.sh "$password"
```

## cap_add, cap_drop

没用过，不了解。

Add or drop container capabilities. See `man 7 capabilities` for a full list.

```yaml
cap_add:
  - ALL

cap_drop:
  - NET_ADMIN
  - SYS_ADMIN
```

## command

```yaml
command: bundle exec thin -p 3000
command: ["bundle", "exec", "thin", "-p", "3000"]
```

## configs

3.3

```yaml
version: "3.3"
services:
  redis:
    image: redis:latest
    deploy:
      replicas: 1
    configs:
      - my_config
      - my_other_config

configs:
  my_config:
    file: ./my_config.txt
  my_other_config:
    external: true
```

```yaml
version: "3.3"
services:

  redis:
    image: redis:latest
    deploy:
      replicas: 1
    configs:
      - source: my_config
        target: /redis_config
        uid: '103'
        gid: '103'
        mode: 0440

configs:
  my_config:
    file: ./my_config.txt
  my_other_config:
    external: true
```

## cgroup_parent

```yaml
cgroup_parent: m-executor-abcd
```

## container_name

```yaml
container_name: my-web-container
```

## credential_spec

没用过，不了解。

3.3

仅用于 Windows 容器。


## deploy

仅用于 `Swarm mode`

```yaml
version: '3'
services:

  redis:
    image: redis:alpine
    deploy:
      # 急群中运行该服务的容器个数
      replicas: 6
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
      labels:
        com.example.description: "This label will appear on the web service"  
```

### endpoint_mode

3.3

```yaml
deploy:
  endpoint_mode: vip
  endpoint_mode: dnsrr
```

### mode

```yaml
deploy:
  mode: global
  mode: replicated
```

### placement

```yaml
deploy:
  placement:
    constraints:
      - node.role == manager
      - engine.labels.operatingsystem == ubuntu 14.04
```

### resources

资源限制

```yaml
deploy:
  resources:
    limits:
      cpus: '0.50'
      memory: 50M
    reservations:
      cpus: '0.25'
      memory: 20M
```

### restart_policy

```yaml
version: "3"
services:
  redis:
    image: redis:alpine
    deploy:
      restart_policy:
        condition: on-failure | none | any
        # 等待时间
        delay: 5s
        # 最大尝试次数
        max_attempts: 3
        window: 120s
```

### update_config

```yaml
version: '3.4'
services:
  vote:
    image: dockersamples/examplevotingapp_vote:before
    depends_on:
      - redis
    deploy:
      replicas: 2
      update_config:
        parallelism: 2
        delay: 10s
        order: stop-first
```

`docker stack deploy` 不支持以下参数


`build`

`cgroup_parent`

`container_name`

`devices`

`dns`

`dns_search`

`tmpfs`

`external_links`

`links`

`network_mode`

`security_opt`

`stop_signal`

`sysctls`

`userns_mode`


## devices

没用过，不了解。

```yaml
devices:
  - "/dev/ttyUSB0:/dev/ttyUSB0"
```

## depends_on

依赖关系

```yaml
version: '3'
services:

  web:
    build: .
    depends_on:
      - db
      - redis

  redis:
    image: redis

  db:
    image: postgres

```

## dns

```yaml
dns: 8.8.8.8

dns:
  - 8.8.8.8
  - 9.9.9.9
```

## dns_search

```yaml
dns_search: example.com

dns_search:
  - dc1.example.com
  - dc2.example.com
```

## tmpfs

```yaml
tmpfs: /run

tmpfs:
  - /run
  - /tmp
```

## entrypoint

入口文件

```yaml
entrypoint: /code/entrypoint.sh

entrypoint:
    - php
    - -d
    - zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so
    - -d
    - memory_limit=-1
    - vendor/bin/phpunit
```

## env_file

从文件读取变量写入镜像 `环境变量`

```yaml
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

```yaml
# 支持 # 号注释
RACK_ENV=development
```

## environment

设置环境变量

```yaml
environment:
  RACK_ENV: development
  SHOW: 'true'
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SHOW=true
  - SESSION_SECRET
```

## expose

内部暴露端口

```yaml
expose:
 - "3000"
 - "8000"
```

## external_links

不建议使用，建议通过网络进行连接。

`CONTAINER:ALIAS`

```yaml
external_links:
 - redis_1
 - project_db_1:mysql
 - project_db_1:postgresql
```

## extra_hosts

```yaml
extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
```

在容器内 `/etc/hosts` 写入下面的内容

```bash
162.242.195.82  somehost
50.31.209.229   otherhost
```

## healthcheck

健康检查

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  # 间隔
  interval: 1m30s
  # 超时时间
  timeout: 10s
  # 重试次数
  retries: 3
```

```yaml
# Hit the local web app
test: ["CMD", "curl", "-f", "http://localhost"]

# As above, but wrapped in /bin/sh. Both forms below are equivalent.
test: ["CMD-SHELL", "curl -f http://localhost && echo 'cool, it works'"]
test: curl -f https://localhost && echo 'cool, it works'
```

## image

```yaml
image: redis
image: ubuntu:14.04
image: tutum/influxdb
image: example-registry.com:4000/postgresql
image: a4bc65fd
```

## isolation

没用过，不了解。

https://docs.docker.com/engine/reference/commandline/run/#specify-isolation-technology-for-container---isolation

Specify a container’s isolation technology. On Linux, the only supported value is `default`. On Windows, acceptable values are `default`, `process `and `hyperv`.

## labels

```yaml
labels:
  com.example.description: "Accounting webapp"
  com.example.department: "Finance"
  com.example.label-with-empty-value: ""

labels:
  - "com.example.description=Accounting webapp"
  - "com.example.department=Finance"
  - "com.example.label-with-empty-value"
```

## links

```yaml
web:
  links:
   - db
   - db:database
   - redis
```

## logging

日志配置

## network_mode

```yaml
network_mode: "bridge"
network_mode: "host"
network_mode: "none"
network_mode: "service:[service name]"
network_mode: "container:[container name/id]"
```

## networks

```yaml
services:
  some-service:
    networks:
     - some-network
     - other-network
```

### aliases

```yaml
services:
  some-service:
    networks:
      some-network:
        aliases:
         - alias1
         - alias3
      other-network:
        aliases:
         - alias2
```

```yaml
version: '2'

services:
  web:
    build: ./web
    networks:
      - new

  worker:
    build: ./worker
    networks:
      - legacy

  db:
    image: mysql
    networks:
      new:
        aliases:
          - database
      legacy:
        aliases:
          - mysql

networks:
  new:
  legacy:
```

### ipv4_address ipv6_address

```yaml
version: '2.1'

services:
  app:
    image: busybox
    command: ifconfig
    networks:
      app_net:
        ipv4_address: 172.16.238.10
        ipv6_address: 2001:3984:3989::10

networks:
  app_net:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
      -
        subnet: 172.16.238.0/24
      -
        subnet: 2001:3984:3989::/64
```

## pid

```yaml
pid: "host"
```

## ports

```yaml
ports:
 - "3000"
 - "3000-3005"
 - "8000:8000"
 - "9090-9091:8080-8081"
 - "49100:22"
 - "127.0.0.1:8001:8001"
 - "127.0.0.1:5000-5010:5000-5010"
 - "6060:6060/udp"
```

3.2 开始支持长格式

```yaml
ports:
  - target: 80
    published: 8080
    protocol: tcp
    mode: host
```

## secrets

```yaml
version: "3.1"
services:
  redis:
    image: redis:latest
    deploy:
      replicas: 1
    secrets:
      - my_secret
      - my_other_secret
secrets:
  my_secret:
    file: ./my_secret.txt
  my_other_secret:
    external: true    
```

```yaml
version: "3.1"
services:
  redis:
    image: redis:latest
    deploy:
      replicas: 1
    secrets:
      - source: my_secret
        target: redis_secret
        uid: '103'
        gid: '103'
        mode: 0440
secrets:
  my_secret:
    file: ./my_secret.txt
  my_other_secret:
    external: true
```

## security_opt

```yaml
security_opt:
  - label:user:USER
  - label:role:ROLE
```

## stop_grace_period

```yaml
stop_grace_period: 1s
stop_grace_period: 1m30s
```

## stop_signal

```yaml
stop_signal: SIGUSR1
```

## sysctls

```yaml
sysctls:
  net.core.somaxconn: 1024
  net.ipv4.tcp_syncookies: 0

sysctls:
  - net.core.somaxconn=1024
  - net.ipv4.tcp_syncookies=0
```

## ulimits

```yaml
ulimits:
  nproc: 65535
  nofile:
    soft: 20000
    hard: 40000
```

## userns_mode

```yaml
userns_mode: "host"
```

## volumes

```yaml
version: "3.2"
services:
  web:
    image: nginx:alpine
    volumes:
      - type: volume
        source: mydata
        target: /data
        volume:
          nocopy: true
      - type: bind
        source: ./static
        target: /opt/app/static

  db:
    image: postgres:latest
    volumes:
      - "/var/run/postgres/postgres.sock:/var/run/postgres/postgres.sock"
      - "dbdata:/var/lib/postgresql/data"

volumes:
  mydata:
  dbdata:
```

```yaml
volumes:
  # Just specify a path and let the Engine create a volume
  - /var/lib/mysql

  # Specify an absolute path mapping
  - /opt/data:/var/lib/mysql

  # Path on the host, relative to the Compose file
  - ./cache:/tmp/cache

  # User-relative path
  - ~/configs:/etc/configs/:ro

  # Named volume
  - datavolume:/var/lib/mysql
```

```yaml
version: "3.2"
services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"

networks:
  webnet:

volumes:
  - type: volume
    source: mydata
    target: /data
    volume:
      nocopy: true
  - type: bind
    source: ./static
    target: /opt/app/static
```

## restart

```yaml
restart: "no"
restart: always
restart: on-failure
restart: unless-stopped
```

## domainname, hostname, ipc, mac_address, privileged, read_only, shm_size, stdin_open, tty, user, working_dir

```yaml
user: postgresql
working_dir: /code

domainname: foo.com
hostname: foo
ipc: host
mac_address: 02:42:ac:11:65:43

privileged: true


read_only: true
shm_size: 64M
stdin_open: true
tty: true
```

## Specifying durations

```yaml
2.5s
10s
1m30s
2h32m
5h34m56s
```

## Volume configuration reference

```yaml
version: "3"

services:
  db:
    image: db
    volumes:
      - data-volume:/var/lib/db
  backup:
    image: backup-service
    volumes:
      - data-volume:/var/lib/backup/data

volumes:
  data-volume:
```

## Network configuration reference

## configs configuration reference

```yaml
configs:
  my_first_config:
    file: ./config_data
  my_second_config:
    external: true
```

```yaml
configs:
  my_first_config:
    file: ./config_data
  my_second_config:
    external:
      name: redis_config
```

## secrets configuration reference

```yaml
secrets:
  my_first_secret:
    file: ./secret_data
  my_second_secret:
    external: true
```

```yaml
secrets:
  my_first_secret:
    file: ./secret_data
  my_second_secret:
    external:
      name: redis_secret
```

## Variable substitution

```yaml
db:
  image: "postgres:${POSTGRES_VERSION}"
```

从 `.env` 文件或系统变量中读取变量，来替换 compose 文件中的变量。

`docker stack deploy` 不支持变量读取。

`$VAR` `${VAR}` 这两种格式都支持。

`${VARIABLE:-default}` 如果 `VARIABLE` 被 `unset` 或为空 (`empty`) 时设置为 `default`。

`${VARIABLE-default}` 如果 `VARIABLE` 被 `unset` 时设置为 `default`。

使用 `$$` 避免解析变量

```yaml
web:
  build: .
  command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"
```

# More Information

* https://docs.docker.com/compose/install/

* https://docs.docker.com/compose/compose-file/
