---
title: LinuxKit 使用
date: 2017-09-14 13:00:00
updated:
comments: true
tags:
- Docker
- LinuxKit
categories:
- Docker
---

OS：macOS

GitHub：https://github.com/linuxkit/linuxkit

<!--more-->

# 准备

```bash
$ brew tap linuxkit/linuxkit
$ brew install --HEAD moby
$ brew install --HEAD linuxkit
```

这一步会安装好 `moby` `linuxkit` 命令。

# 运行官方示例

## VirtualBox

官方文档没提到 VirtualBox (可能不推荐使用)，我这里使用它为了便于理解

```bash
$ git clone git@github.com:linuxkit/linuxkit.git
$ cd linuxkit

$ moby build -format iso-efi linuxkit.yml
```

这样就生成了一个名为 `linuxkit-efi.iso` 的 ISO 文件，使用 `VirtualBox` 以 ISO 方式启动，勾选 `启用EFI` 并设置好 `VirtualBox` 网络。

浏览器访问 `VirtualBox` 的 IP。即可看到 Nginx 默认页面。

## HyperKit

`HyperKit` 是 macOS 上运行的轻量级虚拟化工具包。构建、运行命令如下

```bash
$ moby build linuxkit.yml

$ linuxkit run linuxkit
```

运行 `moby help` `linuxkit help` 查看更多使用方法。

# 自定义

参考示例 `linuxkit.yml` 编写自定义的 `name.yml`，然后构建、运行。

[example](https://github.com/linuxkit/linuxkit/tree/master/examples) 文件夹下的官方示例可供参考。

# 参考链接

* http://blog.csdn.net/shenshouer/article/details/70251109
* https://github.com/moby/tool/blob/master/docs/yaml.md
