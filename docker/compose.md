---
title: Docker Compose version 3 使用详解
date: 2017-06-03 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Define application stacks built using multiple containers, services, and swarm configurations.

<!--more-->

# install

Windows 10 、macOS Docker CE 自带 `docker-compose`，Linux 不包含 `docker-compose` 命令，请在 [GitHub releases](https://github.com/docker/compose/releases) 处下载二进制文件，移入 `PATH` 并赋予可执行权限。

或者执行以下命令进行安装。

```bash
$ DOCKER_COMPOSE_VERSION=1.16.1
$ curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
$ chmod +x docker-compose
$ sudo mv docker-compose /usr/local/bin
$ docker-compose --version
```

## Command-line completion

### fish

```bash
$ mkdir -p ~/.config/fish/completions

# 之后进入该文件

$ wget https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish
```

### bash

参见 [官方文档](https://docs.docker.com/compose/completion/)。

# Compose file reference

## build

```yaml
version: '3'
services:
  webapp:
    build:
      context: ./dir                    # Dockerfile 目录或 git 仓库网址
      dockerfile: Dockerfile-alternate  # Dockerfile 文件名称
      args:
        buildno: 1
    image: webapp:tag
```

## cap_add, cap_drop

待补充

## command

```yaml
command: bundle exec thin -p 3000
command: ["bundle", "exec", "thin", "-p", "3000"]
```

## configs

## cgroup_parent

## container_name

## credential_spec

## deploy

## endpoint_mode

## devices

## depends_on

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

## env_file

```yaml
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

## environment

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

`CONTAINER:ALIAS`

```yaml
expose:
 - "3000"
 - "8000"
```

## external_links

```yaml
```

## extra_hosts

```yaml
extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
```

## healthcheck

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 1m30s
  timeout: 10s
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

## isolation

## labels

## links

```yaml
web:
  links:
   - db
   - db:database
   - redis
```

## logging

## network_mode

```yaml
network_mode: "bridge"
network_mode: "host"
network_mode: "none"
network_mode: "service:[service name]"
network_mode: "container:[container name/id]"
```

## networks

## pid

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

```yaml
ports:
  - target: 80
    published: 8080
    protocol: tcp
    mode: host
```

## secrets

## security_opt

## stop_grace_period

## stop_signal

## sysctls

## ulimits

## userns_mode

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

从 `Shell` 或 `.env` 文件读取变量。

# More Information

* https://docs.docker.com/compose/install/
