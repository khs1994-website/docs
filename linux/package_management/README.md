---
title: Debian 系包管理工具 apt 简介
date: 2016-08-03 13:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
---

`apt` 是 `Debian` `Ubuntu` 上的包管理工具。

<!--more-->

源文件位于 `/etc/apt/sources.list`

# `install`

# `remove`

删除包

# `autoremove`

删除无用的包

# `purge`

删除包及其配置文件

# `update`

升级包列表

# `upgrade`

升级包

# `list`

```bash
$ apt list git

Listing... Done
git/stable,stable,now 1:2.11.0-3+deb9u2 amd64 [installed]
```

不加包名的话，列出所有的包。

# `show`

显示包信息

```bash
$ apt show git
```

# `search`

查找包

```bash
$ apt search git
```

# `full-upgrade`

升级系统

# `edit-sources`

编辑 `apt` 源文件

# dpkg

`dpkg` 命令安装本地的 `deb` 包。

`dpkg -i` 安装包

当缺少依赖的包时，可以使用 `apt install -f` 来安装依赖的包。

`dpkg -r` 删除包

`dpkg -P` 卸载包，并删除配置文件

`dpkg -s` 显示包的详细信息

`dpkg -c` 查询 deb 包文件中所包含的文件
