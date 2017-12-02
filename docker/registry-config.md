---
title: Docker Registry v2 配置文件详解
date: 2017-10-21 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

`/etc/docker/registry/config.yml` 详解。

<!--more-->

你可以在 `docker run` 时通过 `-e` 参数设置环境变量来配置。为了避免命令的繁杂，推荐大家通过挂载配置文件来进行配置。

```yaml
storage:
  filesystem:
    rootdirectory: /var/lib/registry
```

对应着

```yaml
REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/somewhere
```

通过挂载配置文件来修改配置    

```bash
$ docker run -d \
    -p 5000:5000 \
    --restart=always \
    --name registry \
    -v `pwd`/config.yml:/etc/docker/registry/config.yml \
    registry
```

简单配置文件请查看：https://github.com/docker/distribution/blob/master/cmd/registry/config-example.yml

示例配置文件：https://docs.docker.com/registry/configuration/#list-of-configuration-options

```yaml
version: 0.1
log:
  accesslog:
    disabled: true
  level: info | debug | error | warn
  formatter: text | json | logstash
  fields:
    service: registry
    environment: staging
  hooks:
    - type: mail
      disabled: true
      levels:
        - panic
      options:
        smtp:
          addr: smtp.exmail.qq.com:465
          username: docker@xc725.wang
          password: password
          insecure: true
        from: docker@xc725.wang
        to:
          - docker@khs1994.com
# loglevel: debug # deprecated: use "log" 已废弃
# 存储
storage:
  # 存入本地文件中
  filesystem:
    rootdirectory: /var/lib/registry
    maxthreads: 100
  # 存入 阿里云 OSS ,其他国外云服务这里不再列举  
  oss:
    accesskeyid: accesskeyid
    accesskeysecret: accesskeysecret
    region: OSS region name
    endpoint: optional endpoints
    internal: optional internal endpoint
    bucket: OSS bucket
    encrypt: optional data encryption setting
    secure: optional ssl setting
    chunksize: optional size valye
    rootdirectory: optional root directory
  inmemory:  # This driver takes no parameters
  delete:
    enabled: false
  redirect:
    disable: false
  cache:
    blobdescriptor: redis
  maintenance:
    uploadpurging:
      enabled: true
      age: 168h
      interval: 24h
      dryrun: false
    readonly:
      enabled: false
# 用户名 密码 验证功能，提供三种验证方式，我比较熟悉 htpasswd  
auth:
  silly:
    realm: silly-realm
    service: silly-service
  token:
    realm: token-realm
    service: token-service
    issuer: registry-token-issuer
    rootcertbundle: /root/certs/bundle
  htpasswd:
    realm: basic-realm
    path: /path/to/htpasswd
middleware:
  registry:
    - name: ARegistryMiddleware
      options:
        foo: bar
  repository:
    - name: ARepositoryMiddleware
      options:
        foo: bar
  storage:
    - name: cloudfront
      options:
        baseurl: https://my.cloudfronted.domain.com/
        privatekey: /path/to/pem
        keypairid: cloudfrontkeypairid
        duration: 3000s
  storage:
    - name: redirect
      options:
        baseurl: https://example.com/
reporting:
  bugsnag:
    apikey: bugsnagapikey
    releasestage: bugsnagreleasestage
    endpoint: bugsnagendpoint
  newrelic:
    licensekey: newreliclicensekey
    name: newrelicname
    verbose: true
http:
  addr: localhost:5000
  prefix: /my/nested/registry/
  host: https://myregistryaddress.org:5000
  secret: asecretforlocaldevelopment
  relativeurls: false
  tls:
    certificate: /path/to/x509/public
    key: /path/to/x509/private
    clientcas:
      - /path/to/ca.pem
      - /path/to/another/ca.pem
    letsencrypt:
      cachefile: /path/to/cache-file
      email: emailused@letsencrypt.com
  debug:
    addr: localhost:5001
  headers:
    X-Content-Type-Options: [nosniff]
  http2:
    disabled: false
# 类似 github webhooks ,给特定网址 post 一个 json 数据    
notifications:
  endpoints:
    - name: alistener
      disabled: false
      url: https://my.listener.com/event
      headers: <http.Header>
      timeout: 500
      threshold: 5
      backoff: 1000
      ignoredmediatypes:
        - application/octet-stream
#配置 Redis        
redis:
  addr: redis:6379
  # password: asecret
  db: 0
  dialtimeout: 10ms
  readtimeout: 10ms
  writetimeout: 10ms
  pool:
    maxidle: 16
    maxactive: 64
    idletimeout: 300s
# 健康检查    
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
  file:
    - file: /path/to/checked/file
      interval: 10s
  http:
    - uri: http://server.to.check/must/return/200
      headers:
        Authorization: [Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==]
      statuscode: 200
      timeout: 3s
      interval: 10s
      threshold: 3
  tcp:
    - addr: redis-server.domain.com:6379
      timeout: 3s
      interval: 10s
      threshold: 3
# docker hub 镜像      
proxy:
  remoteurl: https://registry-1.docker.io
  username: [username]
  password: [password]
compatibility:
  schema1:
    signingkeyfile: /etc/registry/key.json
validation:
  enabled: true
  manifests:
    urls:
      allow:
        - ^https?://([^/]+\.)*example\.com/
      deny:
        - ^https?://www\.example\.com/
```
