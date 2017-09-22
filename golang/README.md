---
title: Golang 简单使用
date: 2015-12-01 14:00:00
updated:
comments: true
tags:
- Golang
categories:
- Golang
---

官方网站：https://golang.org/

GitHub：https://github.com/golang

<!--more-->

先理解以下变量

`$GOROOT` go 安装路径

`$GOPATH` 用于指定这样一些目录：除 $GOROOT 之外的包含 Go 项目源代码和二进制文件的目录。`go install`和go 工具会用到 $GOPATH：作为编译后二进制的存放目的地和 import 包时的搜索路径。$GOPATH 是一个路径列表，可以同时指定多个目录

`$GOBIN` `go install` 编译存放路径，不允许设置多个路径。

使用 `go env` 查看 go 相关环境变量。

# 目录结构
