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

# 变量

* `$GOROOT` go 安装路径

* `$GOPATH` 路径列表，可以同时指定多个目录

用于指定除 `$GOROOT` 之外的包含 Go 项目源代码和二进制文件的目录。`$ go install` 和 go 工具会用到。

`$GOPATH` 作为编译后二进制的存放目的地和 import 包时的搜索路径。

* `$GOBIN` `$ go install` 编译存放路径，不允许设置多个路径。

* `$GOOS`

* `$GOARCH`

> 使用 `$ go env` 查看 go 相关环境变量。

# 目录结构

`src`

`pkg`

`bin`

# 命令

## go install

## go get

## go build
