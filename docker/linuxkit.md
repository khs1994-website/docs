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

# 修订记录

* 2017/12/02: 官方开始支持 `VirtualBox`

* 2017/11/21: 不再需要 `moby`

# 准备

此处以 `macOS` 下安装为例，其他系统请在 `Go` 环境下编译命令。

GitHub：https://github.com/linuxkit/homebrew-linuxkit

```bash
$ brew tap linuxkit/linuxkit
$ brew install --HEAD linuxkit

# 下面的不是必须安装，我目前还不清楚它的作用

$ brew install --HEAD rtf
$ brew install --HEAD manifest-tool
```

这一步会安装好 `linuxkit` 命令。

工具升级

```bash
$ brew reinstall --HEAD linuxkit
```

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

官方文档：https://github.com/linuxkit/linuxkit/blob/master/docs/platform-vbox.md

先以虚拟机方式启动，便于大家理解。

```bash
$ linuxkit build -format iso-efi linuxkit.yml
```

`-format` 参数指定输出格式，使用 `linuxkit build --help` 查看更多信息。

这样就生成了一个名为 `linuxkit-efi.iso` 的 ISO 文件。

使用 `VirtualBox` 挂载 ISO，勾选 `启用EFI` 并设置好网络后启动。浏览器访问虚拟机的 IP，即可看到 Nginx 默认页面。

或者使用命令运行。

```bash
$ linuxkit run vbox --uefi linuxkit-efi.iso
```

打开 `VirtualBox`，可以看到启动的虚拟机，在网络高级配置中，配置端口转发（例如 `8080`），浏览器访问 `宿主机IP:8080` 即可看到 Nginx 默认页面。

执行 `linuxkit run vbox --help` 查看更多配置参数。

## 使用 HyperKit

官方文档：https://github.com/linuxkit/linuxkit/blob/master/docs/platform-hyperkit.md

`HyperKit` 是 `macOS` 上运行的轻量级虚拟化工具包。构建、运行命令如下

```bash
$ linuxkit build linuxkit.yml

$ linuxkit run -publish 8080:80/tcp linuxkit
```

这里将 `LinuxKit` 中的 `80` 端口映射到了 `macOS` 的 `8080` 端口，现在打开 `127.0.0.1:8080`，即可看到 Nginx 默认页面。

还有一种方法是使用 `Docker for Mac` 启动一个容器，在容器中可以连接到 `LinuxKit` 启动的系统。

连接到容器的方法：https://github.com/linuxkit/linuxkit/blob/master/docs/platform-hyperkit.md#networking

执行 `linuxkit run hyperkit --help` 查看更多配置参数。

>注意：使用该驱动，LinuxKit 中的服务会继承 macOS 中 `/etc/hosts` 的配置。如果想要自定义 `hosts` 可以挂载配置文件。

## macOS xhyve 虚拟引擎

你查看的旧教程可能以 `xhyve` 为例讲解 `Linuxkit`。

不过目前官方已经删去对其的支持。我实际测试启动不起来，这里不再赘述。

# 关闭

执行 `halt` 关闭 `LinuxKit` 启动的系统。

# 自定义

运行 `linuxkit help` 查看更多使用方法。

参考示例 `linuxkit.yml` 编写自定义的 `name.yml`，然后构建、运行。

请参考 [example](https://github.com/linuxkit/linuxkit/tree/master/examples) 文件夹下的官方示例。

# 参考链接

* http://blog.csdn.net/shenshouer/article/details/70251109

* https://www.v2ex.com/t/359038

* https://github.com/moby/tool/blob/master/docs/yaml.md

* https://zhuanlan.zhihu.com/p/26997981
