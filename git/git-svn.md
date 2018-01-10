---
title: git svn 命令详解
date: 2017-08-29 13:00:00
updated:
comments: true
tags:
- Git
categories:
- Git
---

Git SVN 配合使用

<!--more-->

# 拉取 svn 项目

```bash
$ git svn clone  https://svn.code.sf.net/p/intelgraphicsfixup/svn/ intelgraphicsfixup -s --prefix=svn/

$ git branch -av

* master            8b54b14 ComputeLaneCount patch for Azul was removed.
  remotes/svn/trunk 8b54b14 ComputeLaneCount patch for Azul was removed.
```

## 克隆部分 commit

```bash
$ git svn clone -r<开始版本号>:<结束版本号> <svn项目地址> [其他参数]

$ git svn clone -r2:HEAD file:///d/Projects/svn_repo proj1_git -s
```

# 拉取 svn 更新

```bash
$ git svn rebase
```

# 相关链接

* http://www.cnblogs.com/h2zZhou/p/6136948.html
