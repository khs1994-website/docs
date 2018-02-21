---
title: Travis CI 构建 GitBook 实践
date: 2017-07-31 13:00:00
updated:
comments: true
tags:
- GitBook
- CI
- Travis CI
categories:
- CI
- Travis CI
---

本文只提供思路，具体实现请查看本人博客的其他文章。务必对 Travis CI [基础知识](https://www.khs1994.com/ci/travis-ci/README.html) 了解之后再阅读本文。

<!--more-->

刚开始在 `Travis CI` 中从零开始搭建环境，全部执行时间为 `三分半`，将环境部署进 Docker， `docker run XXX` 之后直接开始生成，时间缩短为 `一分半`。

# 准备 GitBook 项目文件

# 新建 `.travis` 文件夹

## 复制根目录 `book.json` 文件

## 编写 `Dockerfile` 文件

```docker
FROM node:9-alpine

ENV TZ=Asia/Shanghai

WORKDIR /srv/gitbook

COPY book.json book.json

COPY docker-entrypoint.sh /usr/local/bin/

RUN apk add --no-cache \
          tzdata \
      && npm install -g gitbook-cli \
      && gitbook install \
      && ln -s /usr/local/bin/docker-entrypoint.sh / \
      && rm -rf /root/.npm /tmp/*

EXPOSE 4000

VOLUME /srv/gitbook-src

WORKDIR /srv/gitbook-src

ENTRYPOINT ["docker-entrypoint.sh"]

CMD server
```

## 编写 `docker-entrypoint.sh` 文件

```bash
#!/bin/sh

START=`date "+%F %T"`

if [ $1 = "sh" ];then sh ; exit 0; fi

rm -rf node_modules _book

cp -a . ../gitbook

cd ../gitbook

main(){
  if [ "$1" = build ];then
    gitbook build
    cp -a _book ../gitbook-src
    echo $START
    exec date "+%F %T"
  fi
  gitbook serve
  exit 0
}

main $1 $2 $3
```

## 编写 `docker-compose.test.yml` 文件

```yaml
sut:
  build: .
  volumes:
    - ../:/srv/gitbook-src
command: build
```

该文件用于 Docker Cloud 在每次提交 PR 时测试。

## 加密 SSH 私钥

该文件一般为 `id_rsa.enc`

# 根目录文件

## 编写 `.travis.yaml`

```yaml
language: bash
sudo: required
services:
- docker
before_install:
- openssl aes-256-cbc -K $encrypted_6cc8cff04075_key -iv $encrypted_6cc8cff04075_iv
  -in .travis/id_rsa.enc -out ~/.ssh/id_rsa -d
- chmod 600 ~/.ssh/id_rsa
- export TZ='Asia/Shanghai'
- date
- git config --global user.name "khs1994"
- git config --global user.email "khs1994@khs1994.com"
script:
- docker run -it --rm -v $PWD:/srv/gitbook-src yeasy/docker_practice build
after_success:
- sudo chmod -R 777 _book
- cd _book
- git init
- git remote add origin "$REPO"
- git add .
- COMMIT=`date "+%F %T"`
- git commit -m "Travis CI Site updated $COMMIT"
- git push -f origin master:"$DEPLOY_BRANCH"
env:
  global:
  - DEPLOY_BRANCH: pages
  - REPO: git@github.com:yeasy/docker_practice.git
addons:
  ssh_known_hosts:
  - github.com
branches:
  only:
  - master
```

## 编写 `docker-compose.yml`

```yaml
version: "3"
services:

  server:
    # build: ./.travis
    image: username/project:latest
    ports:
      - 4000:4000
    volumes:
      - ./:/srv/gitbook-src
    command: server

  build:
    image: username/project:latest
    volumes:
      - ./:/srv/gitbook-src
    command: build

  development:
    build: ./.travis
    image: username/project:latest
    ports:
      - 4000:4000
    volumes:
      - ./:/srv/gitbook-src
    command: server
    # command: build
```

# 构键 Docker 镜像并推送

```bash
# 根目录执行
$ docker-compose build development

$ docker-compose push development
```

不在本地构建镜像也行，在 Docker Cloud 关联 GitHub 仓库构建也可以。

# 推送 GitBook 项目到 GitHub

# 示例

如果不清楚文件夹结构，可以参考：https://github.com/yeasy/docker_practice

# 相关链接

* https://github.com/steveklabnik/automatically_update_github_pages_with_travis_example

* http://blog.csdn.net/qq8427003/article/details/64921201
