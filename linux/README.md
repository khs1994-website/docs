---
title: Linux 常见问题解决方法
date: 2017-07-26 12:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
---

本文列举了 Linux 常见问题及其解决方法。

<!--more-->

# sudo

## 找不到命令

编辑 `/etc/sudoers` 文件。

```bash
Defaults  secure_path=...
# 在后边加上PATH
```

## 脚本输入密码

```bash
echo "password" | sudo -S cmd
```

# 相关链接

* http://blog.csdn.net/wangbole/article/details/17579463
