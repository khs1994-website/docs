---
title: Linux Java 初始化配置
date: 2016-07-02 13:00:00
updated:
comments: true
tags:
- Java
categories:
- Other
- Java
---

Linux 可能自带 openjdk，先将其卸载，之后官网下载再进行安装。

<!--more-->

# 卸载自带 openjdk

```bash
$ rpm -qa | grep java
$ rpm -qa | grep jdk
$ rpm -e --nodeps ***
```

Debian 系请使用 apt 卸载。

# 增加环境变量配置

```bash
$ vi /etc/profile​

#末尾加入以下内容

export JAVA_HOME=/usr/local/jdk1.8.0_92
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```
