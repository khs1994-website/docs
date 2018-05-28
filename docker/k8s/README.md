---
title: Kubernetes 概念总览
date: 2017-12-02 12:00:00
updated:
comments: true
tags:
- K8s
categories:
- K8s
---

`k8s` 已经成为容器集群编排、管理工具的事实领导者。

<!--more-->

# Pod

Pod 是一组紧密关联的容器集合

# ConfigMap

# Secret

# Service

# Deployment

# PersistentVolumeClaim

而 PVC 和 Pod 是资源的使用者，根据业务服务的需求变化而变化，由 K8s 集群的使用者即服务的管理员来配置

# PersistentVolume

PV 和 Node 是资源的提供者，根据集群的基础设施变化而变化，由K8s集群管理员配置

# API 对象

* `metadata`

* `spec`

* `status`
