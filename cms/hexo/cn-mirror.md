---
title: Hexo 国内镜像
date: 2017-10-08 12:00:00
updated:
comments: true
tags:
- Hexo
categories:
- CMS
- Hexo
---

GitHub: https://github.com/khs1994-website/hexo-cn-mirror

<!--more-->

使用 `hexo init` 新建的 Hexo 主题不太好看，我使用的是 [Next 主题](https://github.com/theme-next/hexo-theme-next)。

该镜像替换主题为 Next

直接 `git clone` `npm install` 新建文章即可。

之后重新初始化 git 仓库

```bash
$ rm -rf .git

$ git init

$ git remote add origin git@github.com:username/username.github.io
```
