---
title: Ubuntu 16.04 使用 Swift
date: 2018-01-20 13:00:00
updated:
comments: true
tags:
- iOS
categories:
- Other
- iOS
- Swift
---

本文介绍了在 Ubuntu 16.04 上使用 Swift。

官方网站：https://swift.org/

<!--more-->

# 安装依赖

```bash
$ sudo apt install clang libicu-dev
```

# 下载解压

请到官方网站复制链接下载。

之后将文件的 `/swift_path/usr/bin` 路径加入 `PATH`。

# 简单使用

编写 `hello.swift` 文件。

```swift
printf("Hello, World!")
```

编译，执行

```bash
$ swiftc hello.swift

$ ./hello

Hello, World!
```
