---
title: 终端录屏工具 asciinema
date: 2017-01-05 13:00:00
updated:
comments: true
tags:
- Tools
categories:
- Tools
---

asciinema 是一个用 ClojureScript 编写的开源命令行录屏工具。

<!--more-->

# 安装

## macOS

```bash
$ brew update && brew install asciinema
```

## pip3

```bash
$ sudo pip3 install asciinema
```

# 录制

```bash
$ asciinema rec
```

使用 exit 或者 Ctrl+D 快捷键结束录制。结束录制的时候提示，如果要上传的话，敲回车，这样就不至于把废品也上传了。

上传之后，asciinema 会给出一个网址，如：https://asciinema.org/a/44nu2i2ieywlmqq9wx5sk5k1e 。
