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

此处以 macOS 下安装为例，其他系统请在 go 环境下编译命令。

GitHub：https://github.com/linuxkit/homebrew-linuxkit

```bash
$ brew tap linuxkit/linuxkit
$ brew install --HEAD moby
$ brew install --HEAD linuxkit
$ brew install --HEAD rtf
$ brew install --HEAD manifest-tool
```

保持版本为最新，请将以上命令 `install` 替换为 `reinstall`

这一步会安装好 `moby` `linuxkit` 命令。

# 运行官方示例

支持以下平台：

* HyperKit (macOS)

* Hyper-V (Windows)

* qemu (macOS, Linux, Windows)

* VMware (macOS, Windows)

云平台不再列举。


## 克隆源代码

```bash
$ git clone --depth=1 git@github.com:linuxkit/linuxkit.git

$ cd linuxkit
```

## 使用 VirtualBox

官方不支持，但也可以使用。先以虚拟机方式启动，便于大家理解。

```bash
$ moby build -format iso-efi linuxkit.yml
```

`-format` 参数指定输出格式，使用 `moby build --help`查看更多信息。

这样就生成了一个名为 `linuxkit-efi.iso` 的 ISO 文件，使用 `VirtualBox` 挂载 ISO，勾选 `启用EFI` 并设置好网络后启动。

浏览器访问 `VirtualBox` 的 IP，即可看到 Nginx 默认页面。

## 使用 HyperKit

`HyperKit` 是 macOS 上运行的轻量级虚拟化工具包。构建、运行命令如下

```bash
$ moby build linuxkit.yml

$ linuxkit run -publish 8080:80/tcp linuxkit
```

这里将 LinuxKit 中的 `80` 端口映射到了 macOS `8080` 端口，现在打开 `127.0.0.1:8080`，即可看到 Nginx 默认页面。

连接到容器的方法：https://github.com/linuxkit/linuxkit/blob/master/docs/platform-hyperkit.md#networking

`linuxkit run hyperkit --help` 查看更多用法。

## macOS xhyve 虚拟引擎

官方已经删去对其的支持，具体查看 GitHub。我实际测试启动不起来，这里不再赘述。

# 自定义

运行 `moby help` `linuxkit help` 查看更多使用方法。

参考示例 `linuxkit.yml` 编写自定义的 `name.yml`，然后构建、运行。

请参考 [example](https://github.com/linuxkit/linuxkit/tree/master/examples) 文件夹下的官方示例。

# 参考链接

* http://blog.csdn.net/shenshouer/article/details/70251109

* https://www.v2ex.com/t/359038

* https://github.com/moby/tool/blob/master/docs/yaml.md

* https://zhuanlan.zhihu.com/p/26997981
