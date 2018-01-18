---
title: Docker for Mac 支持 kubernetes
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

<!--more-->

# 相关文章

* [Beta Docker for Mac and Windows with Kubernetes](https://blog.docker.com/2017/10/docker-for-mac-and-windows-with-kubernetes-beta/)

* [bring Kubernetes support to the Docker](https://blog.docker.com/2017/10/kubernetes-docker-platform-and-moby-project/)

* [Docker blog k8s](https://blog.docker.com/tag/kubernetes/)

视频：https://www.bilibili.com/video/av17307986/

# 加入计划

首先使用 Docker 账号在 https://beta.docker.com 注册预览计划，之后在 Docker 菜单登录该 Docker 账号。

# kubectl

之前使用 `brew` 安装了 `kubectl` 请先卸载。

```bash
$ brew remove kubernetes-cli
```

# 启用

官方文档：https://docs.docker.com/docker-for-mac/#kubernetes

在 Docker 设置中启用 k8s（具体图解请查看上方给出的官方文档）。

>注意，需要从 `gcr.io` 拉取以下镜像，由于网络问题可能会失败。

```bash
REPOSITORY                                               TAG                                        IMAGE ID            CREATED             SIZE

gcr.io/google_containers/kube-apiserver-amd64            v1.8.2                                     6278a1092d08        7 weeks ago         194MB
gcr.io/google_containers/kube-controller-manager-amd64   v1.8.2                                     5eabb0eae58b        7 weeks ago         129MB
gcr.io/google_containers/kube-scheduler-amd64            v1.8.2                                     b48970f8473e        7 weeks ago         54.9MB
gcr.io/google_containers/kube-proxy-amd64                v1.8.2                                     88e2c85d3d02        7 weeks ago         93.1MB
gcr.io/google_containers/k8s-dns-sidecar-amd64           1.14.5                                     fed89e8b4248        2 months ago        41.8MB
gcr.io/google_containers/k8s-dns-kube-dns-amd64          1.14.5                                     512cd7425a73        2 months ago        49.4MB
gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64     1.14.5                                     459944ce8cc4        2 months ago        41.4MB
gcr.io/google_containers/etcd-amd64                      3.0.17                                     243830dae7dd        9 months ago        169MB
gcr.io/google_containers/pause-amd64                     3.0                                        99e59f495ffa        19 months ago       747kB
```

之前你可能使用了 `minikube` ，使用以下命令切换到 `docker-for-desktop`。

```bash
$ kubectl config get-contexts

CURRENT   NAME                 CLUSTER                      AUTHINFO             NAMESPACE
          docker-for-desktop   docker-for-desktop-cluster   docker-for-desktop
*         minikube             minikube                     minikube

$ kubectl config use-context docker-for-desktop
```

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

我的博客即将搬运同步至腾讯云+社区，邀请大家一同入驻：https://cloud.tencent.com/developer/support-plan
