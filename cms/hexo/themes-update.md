---
title: Hexo 主题更新问题
date: 2016-03-02 12:00:00
updated:
comments: true
tags:
- Hexo
categories:
- CMS
- Hexo
---

Hexo next 主题从 GitHub clone 到主题文件夹，如果要被项目 Git 跟踪，就得删除主题的 .git 文件夹。这样问题是主题更新比较麻烦，我通过 shell 脚本实现 `无痛` 升级。

<!--more-->

shell 脚本请查看 [GitHub](https://github.com/khs1994/khskit/blob/12304dbfac2d8099231e5dc77f5c4db3b2acbb73/bin/hexo/hexo.sh#L27)
