---
title: Redis Memcached 对比
date: 2018-02-16 13:00:00
updated:
comments: true
tags:
- Redis
- Memcached
categories:
- Cache
---

Redis Memcached 对比

<!--more-->

# 数据结构

`Memcached` 只支持 `String`

# 主从

`Redis` 支持主从

# 持久化

`Memcached` 不能持久化

# 事务

# 存储容量

* Redis 512 MB

* Memcached 1 Mb

# 线程

* `Memcached` 是多线程，非阻塞IO复用的网络模型，分为监听主线程和worker子线程，监听线程监听网络连接，接受请求后，将连接描述字pipe 传递给worker线程，进行读写IO, 网络层使用libevent封装的事件库，多线程模型可以发挥多核作用，但是引入了cache coherency和锁的问题

* `Redis` 使用单线程的 IO 复用模型

* `Redis` 单线程指的是网络请求模块使用了一个线程（所以不需考虑并发安全性），其他模块仍用了多个线程。

## More Information

* https://www.cnblogs.com/qq78292959/archive/2012/12/28/2836868.html
