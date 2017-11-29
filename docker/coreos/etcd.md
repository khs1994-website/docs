---
title: CoreOS etcd 集群实践
date: 2017-08-10 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

集群搭建请查看 [使用 Ignition 配置工具硬盘安装 CoreOS 三节点集群](/docker/coreos/install-disk-new.html)

<!--more-->

# 使用

```bash
core@coreos1 ~ $ etcdctl  member list
3ce690f11cfd6851: name=97dd4eb227ed416989800aab22ebafc8 peerURLs=http://192.168.57.110:2380 clientURLs=http://192.168.57.110:2379 isLeader=false
4ed7a4b9ff92a147: name=243618ffdf54437c9c278673e5ffac53 peerURLs=http://192.168.57.112:2380 clientURLs=http://192.168.57.112:2379 isLeader=true
6eea525a76217d90: name=8ebb8cb013894c81b82d02f60e50e8f5 peerURLs=http://192.168.57.111:2380 clientURLs=http://192.168.57.111:2379 isLeader=false
```

## 在某一节点设置值

```bash
$ etcdctl set /test "CoreOS testing"
```

## 在另一节点获取值

```bash
$ etcdctl get /test

CoreOS testing
```

# 更新记录

* 2017/8 `cloud-config.yaml` (已废弃)，`Ignition` 正在测试中

# 相关链接

* http://blog.csdn.net/u010511236/article/details/52386229

* http://benjr.tw/96404
