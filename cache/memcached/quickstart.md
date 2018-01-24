---
title: Memcached 使用详解
date: 2016-04-12 17:00:00
updated:
comments: true
tags:
- Memcached
categories:
- Cache
- Memcached
---

以 PHP 为例使用 Memcached。

<!--more-->

# 系统类

```php
$m=new Memcached();

$m->addServer('memcached',11211);

// 多台服务器

$m->addServers([
  ['127.0.0.1',11211],
  ['127.0.0.2',11211]
]);

$m->getVersion();

$m->getStats();
```

# 数据操作

```php

// 600 为过期时间

$m->add('key','value',600);

// 若对 key 再次执行 add 一个新值 value2 不能改变原值。

// 替换

$m->replace('key','value',600);

$m->set('key','value',600);

$m->get('key');

$m->delete('key');
```

## 清空

`$m->flush();`

## 增减

`$m->increment('num',5);`

`$m->decrement('num',5);`

## 一次操作多条数据

```php
$array=[
  'key'=>'value',
  'key2'=>'value2'
]

$m->setMulti($array,0);

$m->getMulti(['key1','key2']);

$m->deleteMulti(['key1','key2']);
```

## 错误处理

```php
// 上次操作的返回值

$m->getResultCode()

// 上次操作的返回信息

$m->getResultMessage()
```
