---
title: Git LFS
date: 2016-05-05 13:00:00
updated:
comments: true
tags:
- Git
categories:
- Git
---

GitHub：https://github.com/git-lfs/git-lfs

官方网站：https://git-lfs.github.com/

<!--more-->

# install

二进制软件包在官网自行下载，之后执行

```bash
$ git lfs install
```

此命令只需执行一次。

# 跟踪文件

```bash
$ git lfs track "design-resources/design.psd"

$ git lfs track "*.png"

# list
$ git lfs track
```

# 推送

像往常那样推送就行！

```bash
$ git add .

$ git commit -m "commit message"

$ git push origin master
```

# clone

```bash
$ git lfs clone url
```

# More Information

* https://coding.net/help/doc/git/.html/git-lfs
