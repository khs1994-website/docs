---
title: brew 安装配置
date: 2017-01-01 13:00:00
updated:
comments: true
tags:
- macOS
- brew
categories:
- OS
- macOS
---

访问官网复制脚本安装 https://brew.sh/index_zh-cn.html

<!--more-->

# 常用命令

## 诊断

```bash
$ brew doctor
```

## 清理 如旧包、不再需要的包

```bash
$ brew cleanup
```

## 切换版本

```bash
# 没有执行过 cleanup ,可以切换到以前安装的版本
brew info node
brew switch node 8.2.1
```
