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

GitBook 示例：https://github.com/yeasy/docker_practice

<!--more-->

安装好 [Node.js](/nodejs/README.html)，运行以下命令安装 gitbook

```bash
$ npm install -g gitbook-cli
```

## 初始化

```bash
$ gitbook init
```

生成 `SUMMARY.md` `README.md` 文件

## 编写目录

编写 `SUMMARY.md` 文件，之后执行 `gitbook init` 生成空白的 `*.md` 文件。

也可以先写内容（`*.md` 文件），再增加到目录到 `SUMMARY.md` 文件中。

## 插件

编辑 `book.json` 文件，之后执行以下命令，安装插件。

```bash
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
