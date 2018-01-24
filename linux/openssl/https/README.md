---
title: nginx 配置 TLSv1.3
date: 2018-01-02 13:00:00
updated:
comments: true
tags:
- Linux
- OpenSSL
- https
categories:
- Linux
- OpenSSL
- https
---

将 `即将` 发布的 `TLSv1.3` 作为 `https` 系列的开篇。

GitHub：https://github.com/khs1994-website/tls-1.3

<!--more-->

# 本站其他相关文章

* [Nginx https 配置](https://www.khs1994.com/php/development/nginx-https.html)

* [Let's Encrypt SSL 证书配置详解](https://www.khs1994.com/php/development/nginx-lets-encrypt.html)

* [Https 标签下的文章](https://www.khs1994.com/tags/https/)

# 从 GitHub 克隆 openssl 源码

```bash
$ git clone -b tls1.3-draft-18 --depth=1 https://github.com/openssl/openssl /srv/openssl
```

>这里有个问题，克隆 `master` 分支，最新版的 Chrome 可以访问，但火狐访问不了。克隆 `tls1.3-draft-18` 正好相反。可能是与浏览器支持的草案版本有关，这里不再深入。

# 编译安装 nginx

主要添加以下两项

```bash
--with-openssl=/srv/openssl
--with-openssl-opt='enable-tls1_3'
```

nginx 编译安装请查看 https://www.khs1994.com/php/development/nginx-build.html

# Docker

本人使用 `Dockerfile` 构建镜像，更多信息请查看这里 https://github.com/khs1994-website/tls-1.3

你可以很方便的 `pull` 我构建好的镜像测试 `TLSv1.3`

# nginx 配置

```nginx
server {
  # 为了测试各浏览器对 TLSv1.3 的支持，这里只保留 TLSv1.3
  ssl_protocols            TLSv1.3;

  ssl_ciphers              TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-256-GCM-SHA384:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
}
```

如果有多个子域名配置，必须保证每个配置项中 (`server{ }`) 都启用了 `TLSv1.3`。

浏览器访问测试。

* Chrome 打开 `Chrome://flags` 搜索 TLS 选择 `Enable ***`，不同 Chrome 版本的选项不同，选一个 Enable 开头的就对了。

* 火狐 我用的 beta 版，默认已打开相关选项，无需配置。

我这里只记录相关操作需要注意的地方，细节等详细信息请查看下面的链接。

# 参考链接

* https://imququ.com/post/enable-tls-1-3.html

* https://www.mf8.biz/nginx-tls1-3-draft/
