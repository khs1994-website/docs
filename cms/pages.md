---
title: GitHub Pages 常见问题
date: 2017-09-19 14:00:00
updated:
comments: true
tags:
- GitHub
categories:
- GitHub
---

本文列举了一些使用 `GitHub Pages` 遇到的问题及其解决方法。

<!--more-->

# 资源 404

你可以使用以下方法中的一种来解决该问题。

## 禁用 jekyll

以 `_下划线` 开头的文件及文件夹都会被提示 404，在根目录添加 `.nojekyll` 空白文件禁用 jekyll。

## 包含特定文件

如果不想禁用 jekyll，你可以在项目根目录新建 `_config.yml` 文件，并增加以下内容：

```yaml
theme: jekyll-theme-slate
include: [_images]
```

# 参考链接

* https://post.zz173.com/detail/13522.html
