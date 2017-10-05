---
title: Redis 备份与恢复
date: 2016-04-11 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- DataBase
- Redis
---

本文介绍 Redis 持久化。

<!--more-->

# RDB

该方式为默认方式。

RDB 方式的持久化是通过快照（snapshotting）完成的，当符合一定条件时 Redis 会自动将内存中的所有数据进行快照并存储在硬盘上。进行快照的条件可以由用户在配置文件中自定义，由两个参数构成：时间和改动的键的个数。当在指定的时间内被更改的键的个数大于指定的数值时就会进行快照。配置文件中已经预置了3个条件：

```bash
save 900 1    # 900秒内有至少1个键被更改则进行快照
save 300 10   # 300秒内有至少10个键被更改则进行快照
save 60 10000 # 60秒内有至少10000个键被更改则进行快照
```

可以存在多个条件，条件之间是「或」的关系，只要满足其中一个条件，就会进行快照。如果想要禁用自动快照，只需要将所有的 save 参数删除即可。

Redis 默认会将快照文件存储在当前目录(使用 `CONFIG GET dir` `CONFIG GET dbfilename` 来查看)的 `dump.rdb` 文件中。

配置 `dir` 和 `dbfilename` 两个参数分别指定快照文件的存储路径和文件名。

也可以手动执行 `SAVE` 命令

```bash
redis 127.0.0.1:6379> SAVE    # 该命令将在 redis 备份目录中创建dump.rdb文件。
```

# AOF

append only file

```bash
appendonly yes
appendfilename appendonly.aof

# 当目前的AOF文件大小超过上一次重写时的AOF文件大小的百分之多少时会再次进行重写，如果之前没有重写过，则以启动时的AOF文件大小为依据

auto-aof-rewrite-percentage 100

auto-aof-rewrite-min-size 64mb   # 允许重写的最小AOF文件大小

# appendfsync always             # 每次执行写入都会执行同步，最安全也最慢
appendfsync everysec             # 每秒执行一次同步操作
# appendfsync no                 # 不主动进行同步操作，而是完全交由操作系统来做（即每30秒一次），最快也最不安全
```

Redis 允许同时开启 AOF 和 RDB。

# 复制

## 配置文件

```bash
slaveof master-ip master-port
```

## 启动参数

`--slaveof master-ip master port`

```bash
$ redis-server --port 6380 --slaveof 127.0.0.1 6379
```

## 命令

`SLAVEOF master-ip master-port`

```bash
redis>SLAVEOF 127.0.0.1 6379
```

`SLAVEOF NO ONE` 可以是当前数据库停止接收其他数据库的同步，转成主数据库

# 恢复

如果需要恢复数据，只需将备份文件 `dump.rdb` 或 `appendonly.aof` 移动到 redis dir 目录并启动服务即可。

注意：  

* 当启动参数文件启用 appendonly 时，redis 默认寻找 appendonly.aof 恢复数据，如果没有 aof 文件，则 redis 数据为空

* 当需要使用 rdb 文件恢复数据时，启动参数文件需注释掉 `#appendonly yes`
