---
title: Docker 相关概念总览
date: 2017-10-23 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Docker 概念总览

<!--more-->

# Docker Engine

Docker 引擎

![](https://docs.docker.com/engine/article-img/engine-components-flow.png)

# Docker architecture

Docker 架构

![](https://docs.docker.com/engine/article-img/architecture.svg)

## Docker daemon

Docker 守护进程，`dockerd` 命令

## Docker client

Docker 客户端，`docker` 命令

## Docker registries

Docker 仓库

## Docker objects

Docker 对象

### IMAGES

镜像

### CONTAINERS

容器

### SERVICES

服务

Services allow you to scale containers across multiple Docker daemons, which all work together as a swarm with multiple managers and workers. Each member of a swarm is a Docker daemon, and the daemons all communicate using the Docker API. A service allows you to define the desired state, such as the number of replicas of the service that must be available at any given time. By default, the service is load-balanced across all worker nodes. To the consumer, the Docker service appears to be a single application. Docker Engine supports swarm mode in Docker 1.12 and higher.

## 底层技术

Docker is written in `Go` and takes advantage of several features of the Linux kernel to deliver its functionality.

## Namespaces

命名空间

Docker uses a technology called `namespaces` to provide the isolated workspace called the container. When you run a container, Docker creates a set of namespaces for that container.

These namespaces provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

Docker Engine uses namespaces such as the following on Linux:

* The `pid` namespace: Process isolation (PID: Process ID).

* The `net` namespace: Managing network interfaces (NET: Networking).

* The `ipc` namespace: Managing access to IPC resources (IPC: InterProcess Communication).

* The `mnt` namespace: Managing filesystem mount points (MNT: Mount).

* The `uts` namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).


## Control groups

控制组 `cgroups`

Docker Engine on Linux also relies on another technology called control groups (`cgroups`). A cgroup limits an application to a specific set of resources. Control groups allow Docker Engine to share available hardware resources to containers and optionally enforce limits and constraints. For example, you can limit the memory available to a specific container.

## Union file systems

联合文件系统

Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast. Docker Engine uses UnionFS to provide the building blocks for containers. Docker Engine can use multiple UnionFS variants, including AUFS, btrfs, vfs, and DeviceMapper.

## Container format

容器格式

Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format. The default container format is `libcontainer`. In the future, Docker may support other container formats by integrating with technologies such as `BSD Jails` or `Solaris Zones`.
