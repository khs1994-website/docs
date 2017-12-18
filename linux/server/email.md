---
title: E-mail 服务器配置
date: 2016-08-07 13:00:00
updated:
comments: true
tags:
- Linux
- E-mail
categories:
- Linux
- Server
---

电子邮件是—种用电子手段提供信息交换的通信方式，是互联网应用最广的服务。本次实验采用 `二级域名邮箱:4s.khs1994.com`

<!--more-->

# DNS设置

# hostname

# Postfix (SMTP) 发送

## 安装

## 配置

### main.cf

编辑 `/etc/postfix/main.cf` 文件

### 创建账号

### 启动服务

# Dovecot (IMAP、POP3) 接收

## 安装

## 配置

### dovecot.conf

### 10-mail.conf

### 10-ssl.conf

```bash
ssl = yes
# Preferred permissions: root:root 0444
ssl_cert = </etc/ssl/certs/dovecot.pem
# Preferred permissions: root:root 0400
ssl_key = </etc/ssl/private/dovecot.pem
```

### 20-imap.conf

```bash
protocol imap {
  ssl_cert = </etc/ssl/certs/imap.pem
  ssl_key = </etc/ssl/private/imap.pem
}
```

## 创建储存目录

## 启动服务


# 相关链接

* http://wiki.dovecot.org/SSL/DovecotConfiguration

* http://blog.csdn.net/stwstw0123/article/details/47130293
