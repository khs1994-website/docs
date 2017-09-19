---
title: Java 初始化配置
date: 2016-07-02 13:00:00
updated:
comments: true
tags:
- Java
categories:
- Other
- Java
---

# 卸载自带openjdk

```bash
$ rpm -qa | grep java
$ rpm -qa | grep jdk
$ rpm -e --nodeps ***
```

<!--more-->

# 增加环境变量配置

```bash
$ vi /etc/profile​

#末尾加入以下内容

export JAVA_HOME=/usr/local/jdk1.8.0_92
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```
