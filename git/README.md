---
title: Git 使用详解
date: 2016-05-04 14:00:00
updated:
comments: true
tags:
- Git
categories:
- Git
---

本文列举了 Git 的常用配置及使用方法。

<!--more-->

# 代理设置

```bash
$ git config －l
$ vi ~/.gitconfig
$ git config --global http.proxy 127.0.0.1:1080
$ git config --global https.proxy 127.0.0.1:1080

# 取消代理

$ git config --global --unset http.proxy
$ git config --global --unset https.proxy
```

# 强制PULL

```bash
$ git fetch --all  
# $ git fetch origin
$ git rev-parse --abbrev-ref HEAD
$ git reset --hard origin/master
```

# fork 与上游代码保持更新

```bash
$ git remote -v
$ git remote add source $url
$ git fetch source
$ git branch -av
# 切换分支
$ git rev-parse --abbrev-ref HEAD
$ git checkout master
$ git merge source/master
```

# 拉取远程仓库

```bash
$ git fetch remote_repo remote_branch_name:local_branch_name
```

# 本地分支推送到不同名远程分支

```bash
$ git push -f origin master:gh-pages
```

# 相关链接

* http://www.jianshu.com/p/633ae5c491f5
