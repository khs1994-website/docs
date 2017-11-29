---
title: CoreOS 安装服务本地服务器 Docker 化
date: 2017-08-13 13:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
categories:
- Docker
- CoreOS
---

由于网络问题，避免外网下载镜像占用时间。安装(请查看本博客 CoreOS 分类下的文章)过程中的所需文件全部放到自己搭建的内网服务器。

本博客 [系列文章](https://www.khs1994.com/categories/Docker/CoreOS/) CoreOS 节点全部基于 `virtualbox` 虚拟机。

GitHub：https://github.com/khs1994-docker/coreos

<!--more-->

网卡设置如下：


| 网卡    | 模式                 | IP              |
| :----- | :-------------       |:------         |
| 网卡1   | `hostonly` (静态IP)  | `192.168.57.*`  |
| 网卡2   | 桥接 (`DHCP`)        | `192.168.199.*` |

# 本地服务器配置

IP `192.168.57.1` 位于本机，由于此服务器承载了多项服务，通过指定不同端口号，提供多种服务，本次服务指定端口号 `8080`

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/coreos.git

$ cd coreos
```

## 配置  

修改 `.env` 文件来自定义配置。

# 启动

```bash
$ docker-compose up
```
