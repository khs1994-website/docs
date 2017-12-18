---
title: 使用 Docker 安装 Gitlab
date: 2016-05-03 13:00:00
updated:
comments: true
tags:
- Gitlab
- Docker
categories:
- Git
---

使用 [Docker Compose](/docker/compose.html) 搭建 GitLab。

GitHub：https://github.com/khs1994-docker/gitlab

<!--more-->

# docker-compose.yml

```yaml
version: '3'
services:
  gitlab:
    restart: always
    image: gitlab/gitlab-ce
    ports:
      - "22:22"
      - "443:443"
    volumes:
     - ./config/gitlab:/etc/gitlab
     - ./logs:/var/log/gitlab
     - ./data:/var/opt/gitlab
```

# ssl

在 `./config/nginx/` `./config/gitlab/` 中分别新建 ssl 文件夹，并放入证书文件。

* git.domain.com.crt

* git.domain.com.key

# nginx

在 `./config/nginx/` 新建 `gitlab.conf`，并写入以下内容。

```nginx
server {
  listen 80;
  server_name git.domain.com;
  return 301 https://git.domain.com;
}

server {
  listen       443 ssl http2;
  server_name  git.domain.com;
  ssl_certificate conf.d/ssl/git.domain.com.crt;
  ssl_certificate_key conf.d/ssl/git.domain.com.key;
  location / {
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_pass https://gitlab:443;
  }
}
```

使用以下命令启动

```bash
$ docker-compose up -d
```

# GitLab 配置

修改 `./config/gitlab/gitlab.rb`

```ruby
# note the 'https' below
external_url "https://git.domain.com"
```

使用以下命令重新启动

```bash
$ docker-compose restart
```

访问网页，设置密码。默认用户名为 `root`。

# 参考链接

* [官方文档](https://docs.gitlab.com/omnibus/docker/)
