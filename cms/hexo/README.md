---
title: Hexo 使用详解
date: 2016-03-01 12:00:00
updated:
comments: true
tags:
- Hexo
categories:
- CMS
- Hexo
---

将 `Hexo 博客系统`所需知识大概说明一下。

<!--more-->

# Github

注册 Github，并新建 `用户名.github.io` 仓库

# Git

* 安装 `Git`
* 生成 `SSH` 公钥、密钥
* 将 `公钥` 复制到GitHub

# Node.js

## 换源

# 安装

```bash
$ npm install -g hexo-cli
```

## 初始化

```bash
$ mkdir hexo
$ hexo init <folder>
$ cd <folder>
$ npm install
```

# 配置

## git

```bash
$ npm install hexo-deployer-git --save
```

```yaml
deploy:
   type: git
   repo: git@github.com:khs1994/khs1994.github.io.git
```

# 日常操作

## 生成静态文件

```bash
$ hexo g
```

## hexo server

```bash
$ npm install hexo-server --save
$ hexo server -p 8080     #-p 指定端口
```

## 发布到github

```bash
$ hexo g
$ hexo d
```
