---
title: GitBook 使用详解
date: 2016-05-21 13:00:00
updated:
comments: true
tags:
- Git
- GitBook
categories:
- Git
---

安装好 [Node.js](/nodejs/README.html)，运行以下命令安装 gitbook

```bash
$ npm install -g gitbook-cli
```

<!--more-->

## 初始化

```bash
$ gitbook init
```

生成 `SUMMARY.md` `README.md`

## 写目录

```bash
$ vi SUMMARY.md
$ gitbook init

# 生成空白 *.md 文件
```

## 插件

```bash
$ vi book.json
$ gitbook install
```

# 生成

```bash
$ gitbook build

# 静态文件位于 _book 文件夹
```

# 插件列表

* -sharing                ：自带风享
* -highlight              ：自带代码高亮
* -livereload             ：自带实时生成
* tbfed-pagefooter@git+https://github.com/khs1994/gitbook-plugin-tbfed-pagefooter.git
* prism                   ：代码高亮
* toggle-chapters         ：左侧折叠
* expandable-chapters     ：左侧折叠
* anchor-navigation-ex    ：目录、锚点
* favicon                 ：网站图标

# 相关链接

* https://github.com/zhangjikai/gitbook-use
