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

根据官方文档的层次，分为

* 容器 (`Containers`) 使用 `Docker run`

* 服务 (`Services`) 使用 `Docker Compose` **Defines how containers behave in production**

* 服务栈 (`Stack`) 使用 `Swarm mode` **Defining the interactions of all the services**

# 必须知道

* 使用 [`Dockerfile`](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/) 构建镜像

* 使用 [`multistage builds`](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) 保持镜像最小

* 使用 `Volume` 和 `bind mounts` 管理数据

* 使用 `docker swarm` 部署服务

* 使用 `docker stack` 部署服务栈 `compose 文件`

* 普遍的应用开发最佳实践

# Docker development best practices

Docker 开发最佳实践

## 如何保持镜像最小

* Start with an appropriate base image. 如果你需要 JDK，则直接使用官方的 `openjdk` 镜像，而不要基于 `ubuntu` 安装 `openjdk`

* Use `multistage builds`. 使用多阶段构建，如果你的 Docker 版本不支持 `多阶段构建`，请请尽可能减少镜像层数。

* 使用你自己的基础镜像

* 保持生产环境镜像尽可能小，但允许调试

* 使用有明确含义的镜像标签 `prod` 或者 `test`，尽量不使用 `latest` 标签。

## Where and how to persist application data

应用数据如何存储，存放在哪里

* `避免` 将数据存放在镜像中

* 使用 `volumes` 存放数据

* 在开发环境使用 `bind mounts` ，在生产环境使用 `volume`

* 在生产环境中使用 [`secrets`](https://docs.docker.com/engine/swarm/secrets/) 存储敏感数据，使用 [`configs`](https://docs.docker.com/engine/swarm/configs/) 存储非敏感数据，比如配置文件

## Use swarm services when possible

* 在可能的情况下使用 `Swarm mode`

* 哪怕仅需要运行一个容器，`Swarm mode` 能提供更多的功能

* 通过 `Swarm` 服务，网络和数据卷能够连接和断开

* 一些功能只在 `服务` 中可用,比如 `secrets` `config`，上一部分已经提到

* 使用 `docker stack deploy` pull 镜像，而不是使用 `docker pull`

## Use CI/CD for testing and deployment

* 当程序源码改变或创建了一个 `Pull request`，使用 [Docker Cloud](https://cloud.khs1994.com) 或者其他 CI/CD 自动构建镜像和创建镜像标签并自动测试镜像。Docker cloud 可以把测试通过的镜像部署到生产环境中。

* 使用 Docker EE ，安全团队 sign 一个镜像，之后部署到生产环境中。

## Differences in development and production environments

|Development |	Production |
| :---       | :---        |
| Use bind mounts to give your container access to your source code. |	Use volumes to store container data.|
| Use Docker for Mac or Docker for Windows. 	|Use Docker EE if possible, with userns mapping for greater isolation of Docker processes from host processes.|
|Don’t worry about time drift. |	Always run an NTP client on the Docker host and within each container process and sync them all to the same NTP server. If you use swarm services, also ensure that each Docker node syncs its clocks to the same time source as the containers.|

# 镜像管理

## Docker Hub

## Dcoekr Registry 私有仓库

https://www.khs1994.com/docker/registry.html

## Docker Trusted Registry (Docker EE)
