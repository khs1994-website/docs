---
title: macOS 对 gdb 进行代码签名
date: 2017-01-02 13:00:00
updated:
comments: true
tags:
- macOS
categories:
- OS
- macOS
---

在 macOS 使用 GDB 调试 C 语言代码，必须对 gdb 进行代码签名，否则 GDB 不能运行！

<!--more-->

# 创建证书

钥匙串访问
打开菜单：钥匙串访问－》证书助理－》创建证书...
输入证书名称，如：gdb-cert；
选择身份类型：自签名根证书 （Identity Type to Self Signed Root）
选择证书类型：代码签名 （Certificate Type to Code Signing）
勾选：让我覆盖这些默认签名 （select the Let me override defaults）

一路继续，直到选择存放证书地址，选择：系统

# 设置证书自定义信任

右键刚才创建的 gdb-cert 证书，选择“显示简介” （Get Info）
点击“信任”，会显示可以自定义的信任选项
“代码签名”选择“总是信任” （Code Signing to Always Trust）

# 重启！！！

# 将证书授予gdb

```bash
$ codesign -s gdb-cert /usr/local/bin/gdb
```

# 相关链接

* http://blog.csdn.net/maxwoods/article/details/44410177  
* https://sourceware.org/gdb/wiki/BuildingOnDarwin  
