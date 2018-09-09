---
title: CoreOS 容器编排之路：从 Fleet 到 Kubernetes 的转变（转载）
date: 2017-02-07T13:00:00.000Z
updated: null
comments: true
tags:
  - CoreOS
categories:
  - CoreOS
---

CoreOS 计划于 2018 年 2 月 1 日从 Linux 的容器平台上替换 fleet 技术，对 fleet 的支持也即将截止。

<!-- more -->

CoreOS博客：https://coreos.com/blog/migrating-from-fleet-to-kubernetes.html

翻译：http://dockone.io/article/2277

近两年分布式应用的组织和管理水平大幅提升。CoreOS集群管理始于fleet，fleet是2014年发布的一个简易的分布式服务管理框架。而社区上Kubernetes被广泛应用，并逐渐成为了开源容器框架的事实标准。基于技术应用和市场占有等原因，Kubernetes成为大规模容器架构集群最优秀的自动化编排工具，CoreOS也因此而改变技术选型。本文讲述了CoreOS公司集群编排框架的前世今生，描述了从fleet到Kubernetes的转变。

目前，CoreOS计划于2018年2月1日从Linux的容器平台上替换fleet技术，对fleet的支持也即将截止。fleet进入了维护期，仅负责安全及补丁修复的升级。此项变动代表着集群编排和管理技术将转移到Kubernetes技术上。此转变也简化了用户自动更新容器Linux最小集操作系统的发布和部署操作。

新集群部署将提供以下支持：

- CoreOS Tectonic 为生产环境部署 Kubernete 提供专家支持和交钥匙部署和升级服务
- Linux的容器上使用的开源 Kubernetes 软件
- 用于 Kubernetes 先导帮助的开源 minikube 工具

2018年2月1日以后，fleet 的容器镜像在 CoreOS 的软件注册仓库中仍存在，但不作为 Linux 的容器操作系统集装打包。

若已购买 Linux 容器服务的 fleet 的用户，可在服务终止前从原有渠道获得迁移服务。并获取相关文档。

在此期间，可继续通过 CoreOS 的邮件列表服务解答 fleet 用户的问题。

# fleet：集群化之路的第一步

公司创始之初，CoreOS就致力于研究操作系统的集群编排技术，目前以 CoreOS Linux 容器操作系统最为流行，也是首家提供云环境自动部署和调度集群资源的容器软件。最初该软件是通过fleet实现开源集群调度框架，实现集群设备的系统初始化。

采用 fleet 不到一年，Google 公布了开源 Kubernetes 项目。令人振奋是他推动了 CoreOS Linux 容器操作系统 fleet 的 etcd 分布式键值后台存储技术的发展，更重要的是Kubernetes提供了fleet未提供的今后发展方向和解决方案。

Kubernetes 设计了一套稳定可扩展的API接口、预置服务发现、容器网络、及扩展的关键特性。此外，该技术还在 Google Borg，Omega，and SRE 团队有多年的运营经验。

# Kubernetes and Tectonic：如何编排容器

基于以上原因，在Kubernetes 1.0之前，CoreOS转而将Kubernetes作为容器编排设计的主要特性，将开发资源投入到Kubernetes的相关基础功能和社区支持中去。CoreOS是Cloud Native Computing Foundation（CNCF）的主要成员之一，谷歌将Kubernetes版权捐赠给CNCF产业联盟，这也促使Kubernetes真正成为全行业努力发展的软件成果。

CoreOS的开发团队主导了 Kubernetes 版本周期管理，Special Interest Groups（SIGs）曾用了2年时间简化 Kubernetes 部署、管理和升级，便于生产环境可用。 CoreOS flannel SDN 成为热门的 Kubernetes 网络管理机制。因为 CoreOS 开发的 Kubernetes 网络接口模型作为容器网络接口（CNI）已被大量容器化系统应用。团队致力于设计和应用 Kubernetes 基于角色的访问控制（RBAC）的技术，使得开源身份认证解决方案dex的团队补充了认证提供商和类似LDAP的企业级解决方案。当然，etcd 原本作为fleet的后台数据存储，代表了早期的努力，也将继续沿用到 Kubernetes 的时代中。

fleet 探索了集群自动化管理的愿景，CEO Alex Polvi 认为 Kubernetes 帮助 CoreOS 达到最终目标。感谢过去社区对 fleet 的反馈和支持，公司已将多年积累的经验和思路应用到 Kubernetes和 Tectonic 的集群容器编排上。

## 在 CoreOS Tectonic 上开始使用 Kubernetes

Tectonic提供一种最简易的构建新集群方式。在应用开源 Kubernetes 的基础上，它提供了集群编排软件的简单安装和自动升级服务。对于10个节点以内规模的集群的设备提供免费测试应用 lisence，并支持AWS和裸机部署两种环境。

## minikube 是 Kubernetes 的简易先导

若是个使用容器编排的新手，minikube工具可帮助用户在本地快捷的运行 Kubernetes ，也是一个可安装在笔记本或本地电脑上的 Kubernetes 先导帮助工具。

## 让 Kubernetes 开启 CoreOS Container Linux 之旅

为了深入研究 Kubernetes 的技术细节，可参考部署帮助手册。帮助文档提供了 Kubernetes 相关概念的解释说明，以及一些超出Tectonic两类初始环境外的平台部署技术。

# 为 fleet 容器提供集群继续提供维护支持

在2018年2月 fleet 将从容器的 Alpha 版本上删除，随后将从 Beta 和稳定版本上删除，而此后版本可通过运行容器环境继续使用 fleet。有一个简单封装的脚本可帮助客户获取 fleet 应用容器软件及安装说明。

管理员们可通过调试" fleet 迁移配置示例"实现容器化 fleet 应用部署的迁移。设备提供商可在 fleet 节点上部署封装配置以激活服务。

# 下一步：从 fleet 迁移到 Kubernetes

可加入 CoreOS 的 [Container Linux 邮件列表](https://groups.google.com/forum/#!forum/coreos-user)或 IRC 以获得反馈或技术支持。也可在2月14日的现场技术研讨会获得更多信息。最终，建议参加 Coreos 的 Kubernetes 的专家面授培训，帮助开始 Kubernetes 的正式使用。
