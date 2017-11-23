---
title: 在开发环境使用 Docker
date: 2017-10-17 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文是对官方文档的总结与备注。

官方文档：https://docs.docker.com/develop/

<!--more-->

* 使用 `Dockerfile` 构建镜像

* 使用 [`multistage builds`](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) 保持镜像最小

* 使用 `Volume` 和 `bind mounts` 管理数据

* 使用 Docker Swarm 部署服务

* 使用 Docker Compose 部署服务

# Docker development best practices

Docker 开发最佳实践

## 如何保持镜像最小

* Start with an appropriate base image. 如果你需要 JDK，则直接使用官方的 `openjdk` 镜像，而不要基于 `ubuntu` 安装 `openjdk`

* Use multistage builds. 使用多步构建，如果你的 Docker 版本不支持 `多步构建`，请请尽可能减少镜像层数。

## Where and how to persist application data

* 避免将数据存放在镜像中

* 使用 `volumes` 存放数据

* 在开发环境使用 `bind mounts` ，在生产环境使用 `volume`

* 在生产环境中使用 [`secrets`](https://docs.docker.com/engine/swarm/secrets/) 存储敏感数据，使用 [`configs`](https://docs.docker.com/engine/swarm/configs/) 存储非敏感数据，比如配置文件

## Use swarm services when possible

* 在可能的情况下使用 Docker Swarm

* 使用 `docker stack deploy` pull 镜像，而不是使用 `docker pull`

## Use CI/CD for testing and deployment

# 镜像管理

## Docker Hub

## Dcoekr Registry

## Docker Trusted Registry (Docker EE)
