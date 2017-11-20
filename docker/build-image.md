---
title: Docker 镜像云端构建（官方+国内)
date: 2017-10-01 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

将 Dockerfile 上传到代码仓库(GitHub, GitLab, Coding, etc)，云端开始构建并 push Docker 镜像。这里只列出免费服务。

<!--more-->

# Docker Hub

Docker 官方标记为 `废弃`

# Docker Cloud

Docker 官方推荐

https://cloud.docker.com

# Travis CI

https://travis-ci.org

只支持与 GitHub 绑定

# 阿里云

提供高性能本地化 Registry，上传/下载/构建及托管的全方位镜像服务。已经与(code.aliyun.com)/Github/Bitbucket 代码源打通，提供 Docker 镜像的持续集成服务。

提供国内、国外构建环境。

https://dev.aliyun.com/search.html?spm=5176.1971733.0.1.trlkKn

# 腾讯云

https://console.cloud.tencent.com/ccs/registry

据 QQ 交流群 434653499 构建主机位于国外。

镜像前缀 `ccr.ccs.tencentyun.com`

# More Information

* https://developer.aliyun.com/index?spm=5176.8142029.388261.181.H1inl7#guid-850376
