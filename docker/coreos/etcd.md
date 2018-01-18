---
title: CoreOS etcd3 集群实践
date: 2017-08-10 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
- Etcd
categories:
- Docker
- CoreOS
---

集群搭建请查看 [使用 Ignition 配置工具硬盘安装 CoreOS 三节点集群](install-disk-new.html)。

<!--more-->

本文内容基于 `etcd3`。

`CoreOS` 中的 `etcd` 是以 `rkt` 容器方式启动的。自带的 `etcd2` 命令已经过时，操作请使用 `etcdctl`。

```bash
$ rkt list

UUID		APP	IMAGE NAME			STATE	CREATED		STARTED		NETWORKS
57581644	etcd	quay.io/coreos/etcd:v3.2.10	running	1 minute ago	1 minute ago
```

先设置环境变量(不是必须)，经过我的验证，如果 etcd 启动成功，不用设置也行。

```bash
$ export ETCDCTL_API=3
```

# 使用 Docker 模拟集群

你也可以使用 `Docker Compose` 模拟一个集群

具体请查看：https://github.com/yeasy/docker_practice/blob/master/etcd/cluster.md

# 查看节点列表

```bash
core@coreos1 ~ $ etcdctl  member list
3ce690f11cfd6851: name=97dd4eb227ed416989800aab22ebafc8 peerURLs=http://192.168.57.110:2380 clientURLs=http://192.168.57.110:2379 isLeader=false
4ed7a4b9ff92a147: name=243618ffdf54437c9c278673e5ffac53 peerURLs=http://192.168.57.112:2380 clientURLs=http://192.168.57.112:2379 isLeader=true
6eea525a76217d90: name=8ebb8cb013894c81b82d02f60e50e8f5 peerURLs=http://192.168.57.111:2380 clientURLs=http://192.168.57.111:2379 isLeader=false
```

# 在某一节点设置值

```bash
$ etcdctl put key "CoreOS testing"
OK
```

# 在另一节点获取值

```bash
$ etcdctl get key
key
CoreOS testing
```

# 相关链接

* http://blog.csdn.net/u010511236/article/details/52386229

* http://benjr.tw/96404
