---
title: Django 初始化配置
date: 2015-02-01 13:00:00
updated:
comments: true
tags:
- Python
- Django
categories:
- Python
- Django
---

创建工程

```bash
$ django-admin startproject myblog
```

<!--more-->

创建应用

>分隔功能，一个功能对应一个应用

```bash
$ python3 manage.py startapp blog
```

在 `settings.py` 中添加应用

```python
INSTALLED_APPS = [
...
'blog',
]
```

# 启动服务

>测试使用，后续使用 Nginx

```bash
$ python3 manage.py runserver
```

# 模板

在应用目录下新建 `Templates` 文件夹存放 `HTML` 文件

# 生成数据表

```bash
$ python3 manage.py makemigrations blog

$ python3 manage.py migrate

# 查看SQL语句

$ python3 manage.py sqlmigrate blog 0001

# 创建用户

$ python3 manage.py createsuperuser

# 静态资源
```

修改 `settings.py`

```bash
# 新文件夹

STATIC_ROOT = "/var/www/example.com/static/"

# 转移文件

$ python3 manage.py collectstatic
```

官方指南：https://docs.djangoproject.com/en/1.11/howto/static-files/

# Nginx 配置

## 安装 uwsgi

```bash
$ python3 -m pip install uwsgi
```

## 配置文件方式启动

`uwsgi.ini`

```yaml
# myweb_uwsgi.ini file
[uwsgi]

# Django-related settings

#http = :8010
socket = :8010
# the base directory (full path)
chdir = /Users/khs1994/WorkSpace/PycharmProjects/django_demo/

# Django s wsgi file
module = django_demo.wsgi

# process-related settings
# master
master = true

# maximum number of worker processes
processes = 4

# ... with appropriate permissions - may be needed
# chmod-socket    = 664
# clear environment on exit
vacuum = true
buffer-size = 32768
```

```bash
$ uwsgi --ini uwsgi.ini
```

## Nginx 配置

```nginx
server {
  listen 80;
  server_name django.tkhs1994.com;
  charset utf-8;
  location / {
    include  uwsgi_params;
    uwsgi_pass  127.0.0.1:8010;
    uwsgi_param UWSGI_SCRIPT untitled.wsgi;
    uwsgi_param UWSGI_CHDIR /Users/khs1994/WorkSpace/PycharmProjects/untitled;
    index  index.html index.htm;
    client_max_body_size 35m;

    # http代理，根据 ini 配置文件端口指定的协议进行选择
    #proxy_pass http://127.0.0.1:8010/;
    #proxy_set_header Host $host;
    #proxy_set_header X-Real-IP $remote_addr;
    #proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    #proxy_set_header X-Forwarded-Proto "http";
  }
}
```
