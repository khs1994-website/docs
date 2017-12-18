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

```php
$m=new Memcached();
$m->addServer('memcached',11211);
$m->getVersion();
$m->getStats();
```

# 数据操作

add 不会替换原值

`$m->add('key','value',600);`

`$m->replace('key','value',600);`

`$m->set('key','value',600);`

`$m->delete('key');`

## 清空

`$m->flush();`

`$m->increment('num',5);`

`$m->decrement('num',5);`

```php
$array=[
  'key'=>'value',
  'key2'=>'value2'
]
```

## 一次操作多条数据

`$m->setMulti($array,0);`

`$m->getMulti(['key1','key2']);`

`$m->deleteMulti(['key1','key2']);`

## 返回结果

`$m->getResultCode()`

`$m->getResultMessage()`
