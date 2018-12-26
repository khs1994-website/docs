---
title: 基于 CoreOS 手动部署 Kubernetes
date: 2018-07-01 12:00:00
updated:
comments: true
tags:
- K8s
categories:
- K8s
---

GitHub: https://github.com/khs1994-docker/lnmp-k8s/tree/master/coreos

<!--more-->

分为 `master` 和 `worker` 节点。

1. 部署 Etcd 集群

2. flannel 将网络配置写入 Etcd 集群，并配置 Docker 网络设置

3. Docker 根据网络配置启动

4. 启动 Kubernetes 组件
