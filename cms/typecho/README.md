---
title: Typecho 使用详解
date: 2016-03-03 13:00:00
updated:
comments: true
tags:
- Typecho
categories:
- CMS
- Typecho
---

`Typecho` 是一款类似于 `WordPress` 的基于 `PHP` 的站点搭建工具。

<!--more-->

# nginx 配置

```nginx
server {
    listen          80;
    server_name     yourdomain.com;
    root            /home/yourdomain/www/;
    index           index.html index.htm index.php;

    if (!-e $request_filename) {
        rewrite ^(.*)$ /index.php$1 last;
    }


    location ~ .*\.php(\/.*)*$ {
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include fastcgi.conf;
    }
}
```

# 相关链接

* http://docs.typecho.org/faq
