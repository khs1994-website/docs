---
title: WordPress 使用详解
date: 2016-03-04 13:00:00
updated:
comments: true
tags:
- WordPress
categories:
- CMS
- WordPress
---

安装 `PHP` `MySQL` 。

<!--more-->

# FTP错误

在 WordPress 目录下找到 `wp-config.php` 文件，在最后一行加上 `define('FS_METHOD', "direct");`
