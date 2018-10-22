---
title: Docker 桌面版支持 kubernetes
date: 2017-12-20 13:00:00
updated: 2018-06-01 13:00:00
comments: true
tags:
- Docker
- K8s
categories:
- Docker
---

Docker for Mac & Windows 支持 k8s。

<!--more-->

# 修订记录

* 稳定版已经支持 k8s

# 网络环境

需要从 `gcr.io` 拉取镜像，国内网络一般不能够拉取到镜像！

解决办法请查看 https://github.com/khs1994-docker/lnmp/issues/520

# 相关文章

* [bring Kubernetes support to the Docker](https://blog.docker.com/2017/10/kubernetes-docker-platform-and-moby-project/)

* [Docker blog k8s](https://blog.docker.com/tag/kubernetes/)

视频：https://www.bilibili.com/video/av17307986/

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

# 使用

虽然 Docker 桌面版上的 k8s 支持使用 compose 文件进行部署。

但为了更好的学习，建议使用 `kubectl` 及 `*.yaml` 文件进行学习。
