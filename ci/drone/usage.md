---
title: Docker Drone CI/CD 用法举例
date: 2018-01-04 13:00:00
updated:
comments: true
tags:
- CI
- Drone
categories:
- CI
- Drone
---

官方文档：http://docs.drone.io/getting-started/

官方文档：http://docs.drone.io/zh/getting-started/

<!--more-->


Drone 本质就是在指定的 Docker 容器中执行命令。

与其他 CI/CD 类似，项目中必须包含 `.drone.yml` 文件来定义工作流，才能开始使用。

# 命令行工具

https://github.com/drone/drone-cli/releases

下载之后移入 `PATH`

# 用法举例

```yaml
clone:
  git:
    image: plugins/git
    #
    # 克隆深度
    #
    depth: 50
    recursive: true
    submodule_override:
      #
      # 重写 git 子模块地址
      #
      # @link http://plugins.drone.io/drone-plugins/drone-git/
      #
      tests/resource: http://192.168.199.100:3000/khs1994/image.git

#
# 默认克隆到 /drone/src/github.com/username/hello-world
#

workspace:
  base: /go
  #
  # 克隆到了 /go/src/github.com/octocat/hello-world
  #
  path: src/github.com/octocat/hello-world
  #
  # 克隆到 /go
  #
  path: .

pipeline:
  backend:
    #
    # 每次构建时总是拉取镜像
    #
    pull: true
    #
    # 同一 group 会并行执行
    #
    group: build
    image: golang
    image: gcr.io/custom/golang
    environment:
      - CGO=0
      - GOOS=linux
      - GOARCH=amd64
    commands:
      - export PATH=$PATH:/go
      # - export PATH=${PATH}:/go
      # ${VAR} 这类变量不能被解析
      - export PATH=$${PATH}:/go
      - sleep 15
      - go get
      - go build
      - go test
    #  
    # 特定状态才构建
    #
    # @link  http://docs.drone.io/conditional-steps/
    #
    when:
      branch: master
      event: [push, pull_request, tag, deployment]
      #
      # 指定平台
      #
      platform: linux/amd64
      status: changed
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    volumes: [ /etc/ssl/certs:/etc/ssl/certs ]
    privileged: true     

  frontend:
    #
    # 同一 group 会并行执行
    #
    group: build
    image: node:6
    commands:
      - npm install
      - npm test

  publish:
    #
    # http://plugins.drone.io/drone-plugins/drone-docker/
    #
    image: plugins/docker
    registry: registry.heroku.com
    repo: foo/bar
    tags: latest
    when:
      #
      # $ drone deploy octocat/hello-world 24 staging
      #
      # 命令行执行 deploy 命令才会执行
      #
      event: deployment
      environment: staging
    # username: username
    # password: password
    #
    # 密钥这里小写，实际系统引用的时候会自动变成大写
    #
    secrets: [ docker_username, docker_password ]
    secrets:
      - source: docker_prod_password
        target: docker_password   

  notify:
    image: plugins/slack
    channel: developers
    username: drone
    when:
      status: [ success, failure ]    

services:
  #
  # 服务使用 mysql 作为 host,下同
  #
  mysql:
    image: mysql
    environment:
      - MYSQL_DATABASE=test
      - MYSQL_ALLOW_EMPTY_PASSWORD=yes

  redis:
    image: redis

# 只构建以下分支

branches: master

branches: [ master, dev]

branches:
  include: [ master, feature/* ]

# 除了以下分支，都构建

branches:
  exclude: [ develop, feature/* ]
```

## 跳过构建

`commit` 信息加上 `[ci skip]`。

```bash
$ git commit -m "updated README [CI SKIP]"
```

# 矩阵构建

http://docs.drone.io/zh/matrix-builds/

```yaml
pipeline:
  build:
    image: ${IMAGE}
    commands:
      - go build
      - go test

matrix:
  IMAGE:
    - golang:1.7
    - golang:1.8
    - golang:latest
```

# 密钥

## Docker 仓库相关密钥

构建过程需要私有仓库镜像，这个配置来使得 drone 能够拥有相关权限

```bash
$ drone registry add \
    --repository username/hello-world \
    --hostname gcr.io \
    # --hostname docker.io \
    --username <name> \
    --password <value>
```

## 增加密钥

```bash
$ drone secret add \
    -repository username/hello-world \
    -image plugins/docker \
    -name docker_username \
    -value <value>
```

指定的事件才能使用这个密钥。

```bash
$ drone secret add \
    -repository username/hello-world \
    -image plugins/docker \
    -event pull_request \
    -event push \
    -event tag \
    -name docker_username \
    -value <value>
```

# 系统内置变量

http://docs.drone.io/environment-reference/
