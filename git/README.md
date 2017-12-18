---
title: Git 使用详解
date: 2016-05-20 14:00:00
updated:
comments: true
tags:
- Git
categories:
- Git
---

本文列举了 Git 的常用配置及使用方法。

<!--more-->

# 配置

查看配置

```bash
$ git config -l
```

或者直接编辑 `~/.gitconfig` 文件，但不推荐。

## 代理设置

```bash
$ git config －l
$ git config --global http.proxy 127.0.0.1:1080
$ git config --global https.proxy 127.0.0.1:1080

# 取消代理

$ git config --global --unset http.proxy
$ git config --global --unset https.proxy
```

# 查看当前位于哪个分支

```bash
# 准确打印分支，可能在 shell 脚本中用的多
$ git rev-parse --abbrev-ref HEAD

# git branch
```

# 将本地仓库与远程仓库保持一致

```bash
$ git fetch --all

# $ git fetch origin

# 假设当前位于 master 分支，想要与远程的 master 分支保持一致
# 若是其他分支请将 master 换为其他分支名即可

$ git reset --hard origin/master
```

# fork 与上游代码保持更新

```bash
$ git remote -v

# 将 $url 替换为上游仓库地址

$ git remote add source $url
$ git fetch source

# 假设当前位于 master 分支，想要与上游的 master 分支保持一致
# 若是其他分支请将 master 换为其他分支名即可

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

# tag

## 删除远程分支

```bash
$ git push origin --delete tag <tagName>
```

# 相关链接

* http://www.jianshu.com/p/633ae5c491f5

* https://blog.zengrong.net/post/1746.html
