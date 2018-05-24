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

```bash
$ git config -g user.name "khs1994"

$ git config -g user.email "khs1994@khs1994.com"
```

<!--more-->

# 常见错误

## 将本地分支与远程分支关系建立起来

```bash
$ git branch --set-upstream dev origin/dev
```

# 永久删除大文件

* https://help.github.com/articles/removing-sensitive-data-from-a-repository/

自行替换 `*.db` 为自己的文件规则

```bash
$ git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch *.db' --prune-empty --tag-name-filter cat -- --all

$ rm -rf .git/refs/original/
$ git reflog expire --expire=now --all
$ git gc --prune=now
$ git gc --aggressive --prune=now
$ git push origin --force --all
$ git push origin --force --tags
```

# 子模块

```bash
# 拉取子模块
$ git submodule update --init --recursive

$ git submodule add URL DIR
```

# 配置

查看配置

```bash
$ git config -l
```

或者直接编辑 `~/.gitconfig` 文件，但不推荐。

## 代理设置

`--unset` 取消代理

```bash
$ git config --global [--unset] http.proxy 127.0.0.1:1080

$ git config --global [--unset] https.proxy 127.0.0.1:1080
```

# 分支

## 查看当前位于哪个分支

```bash
# 准确打印分支，可能在 shell 脚本中用的多

$ git rev-parse --abbrev-ref HEAD

# git branch
```

## 基本操作

```bash
$ git checkout -b NEW_BRANCH

# 等价于以下命令

$ git branch NEW_BRANCH ; git checkout NEW_BRANCH

$ git branch {-D | -d} BRANCH_NAME
```

# 恢复

## 本地仓库与远程仓库保持一致(强制覆盖)

```bash
# 拉取远程所有分支

$ git fetch [origin] [branch] [--all]

# 假设当前位于 master 分支，想要与远程的 master 分支保持一致

# 若是其他分支请将 master 换为其他分支名即可

$ git reset --hard origin/master
```

## 恢复某文件到上一次 commit 状态（未 add）

```bash
$ git checkout -- modify.md
```

## 将 add 的文件移出

```bash
$ git reset HEAD file.md
```

# fork 与上游代码保持更新

```bash
$ git remote -v

$ git remote add source URL

$ git fetch source

# 假设当前位于 master 分支，想要与上游的 master 分支保持一致
# 若是其他分支请将 master 换为其他分支名即可

$ git rebase source/master
```

# 拉取远程仓库的分支（本地分支不存在）

```bash
$ git fetch remote_repo remote_branch_name:local_branch_name
```

# 本地分支推送到不同名远程分支

```bash
$ git push origin master:gh-pages
```

# tag

```bash
$ git tag TAG_NAME commit号

$ git tag -a TAG_NAME -m "DESCRIPT" commit号

$ git show TAG_NAME

$ git tag -d TAG_NAME # delete

$ git push origin {TAG_NAME | --tags}
```

## 删除远程标签

```bash
$ git push origin --delete tag <tagName>
```

# Stash

暂时储藏已修改未提交的文件，修复 bug 时会用到。

```bash
$ git stash

# 返回到了上次 commit 的状态,开始修复问题

$ vi bug_file

$ git add . ; git commit -m "fix xxx"

$ git stash list

$ git stash apply [stash@{0}]

$ git stash pop # apply last stash and remove it from the list

$ git stash clear
```

# commit

```bash
$ git commit --amend # 重新编辑上一次提交
```

# 相关链接

* http://www.jianshu.com/p/633ae5c491f5

* https://blog.zengrong.net/post/1746.html

* https://github.com/liuhui998/gitbook
