---
title: Alpine Linux 包管理工具 apk 简介
date: 2016-08-02 13:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
---

官方 Wiki：https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management

<!--more-->

由于基于 `Alpine` 的 Docker 镜像体积较 `Debian` 小很多，很有必要学习一下 Alpine 的包管理工具 `apk`。就像 CentOS 的 `yum`，Ubuntu 的 `apt`。

源文件位于 `/etc/apk/repositories`

你可以在这里搜索所有的包 http://pkgs.alpinelinux.org/packages

# 安装

```bash
$ apk add
```

## 参数

`--no-cache`

## 用法举例

```bash
$ apk add --no-cache --virtual .name git openssh-client

$ apk del .name
```

这种用法在 `Dockerfile` 中很常见，将多个包的集合命名为一个名称，方便了后续卸载。

# 卸载

```bash
$ apk del
```

# 更新

## 更新包列表

```bash
$ apk update
```

## 升级所有已安装的包

```bash
$ apk upgrade
```

# 搜索

```bash
$ apk search
```

# 查看包信息

```bash
# 列出所有已安装的包

$ apk info

# 列出某个包的详情

$ apk info git
```
