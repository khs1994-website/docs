---
title: Docker 桌面版支持 kubernetes
date: 2017-12-20 13:00:00
updated:
comments: true
tags:
- Docker
- K8s
categories:
- Docker
---

Docker for Mac v17.12 正式支持 k8s。

Docker for Windows v18.02-rc1 正式支持 k8s。

<!--more-->

# 网络环境

需要从 `gcr.io` 拉取镜像，国内网络一般不能够拉取到镜像！网络问题请读者自行解决。

# 相关文章

* [Beta Docker for Mac and Windows with Kubernetes](https://blog.docker.com/2017/10/docker-for-mac-and-windows-with-kubernetes-beta/)

* [bring Kubernetes support to the Docker](https://blog.docker.com/2017/10/kubernetes-docker-platform-and-moby-project/)

* [Docker blog k8s](https://blog.docker.com/tag/kubernetes/)

视频：https://www.bilibili.com/video/av17307986/

# 加入计划

>可能需要此步骤

使用 Docker 账号在 https://beta.docker.com 注册预览计划，之后在 Docker 菜单登录该 Docker 账号。

# kubectl

之前使用 `brew` 安装了 `kubectl` 请先卸载。

```bash
$ brew remove kubernetes-cli
```

之前你可能使用了 `minikube` ，使用以下命令切换到 `docker-for-desktop`。

```bash
$ kubectl config get-contexts

CURRENT   NAME                 CLUSTER                      AUTHINFO             NAMESPACE
          docker-for-desktop   docker-for-desktop-cluster   docker-for-desktop
*         minikube             minikube                     minikube

$ kubectl config use-context docker-for-desktop

# 切换回 minikube 的命令

$ kubectl config use-context minikube
```

# 启用

在 Docker 设置中启用 k8s，具体图解请查看 [官方文档](https://docs.docker.com/docker-for-mac/#kubernetes)。

## 查看集群详情

```bash
$ kubectl cluster-info

Kubernetes master is running at https://localhost:6443
KubeDNS is running at https://localhost:6443/api/v1/namespaces/kube-system/services/kube-dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

## 查看节点

```bash
$ kubectl get node

NAME                 STATUS    ROLES     AGE       VERSION
docker-for-desktop   Ready     master    8h        v1.8.2
```

# 使用 docker 命令部署 k8s 服务

官方文档：https://docs.docker.com/docker-for-mac/kubernetes/

新建 `docker-compose.yml` 文件。

```yaml
version: '3.3'

services:
  web:
    build: web
    image: dockerdemos/lab-web
    volumes:
     - "./web/static:/static"
    ports:
     - "80:80"

  words:
    build: words
    image: dockerdemos/lab-words
    deploy:
      replicas: 5
      endpoint_mode: dnsrr
      resources:
        limits:
          memory: 16M
        reservations:
          memory: 16M

  db:
    build: db
    image: dockerdemos/lab-db
```

## 部署服务

```bash
$ docker stack deploy --compose-file docker-compose.yml mystack
```

## 查看服务详情

```bash
$ docker stack services mystack

# or

$ kubectl get services
```

## 指定命名空间

默认的命名空间为 `default`，使用以下命令自定义命名空间。

```bash
$ docker stack deploy --namespace my-app --compose-file docker-compose.yml mystack
```

## Swarm mode 部署

如果你想使用 Swarm mode 相关命令，你必须在前面加上 `DOCKER_ORCHESTRATOR=swarm`

```bash
$ DOCKER_ORCHESTRATOR=swarm docker node ls

$ DOCKER_ORCHESTRATOR=swarm docker stack deploy --compose-file /path/to/docker-compose.yml mystack
```
