---
title: Codecov 展示代码覆盖率
date: 2018-06-07 13:00:00
updated:
comments: true
tags:
- CI
- Codecov
categories:
- CI
- Codecov
---

官方网站：https://codecov.io

GitHub：https://github.com/codecov/codecov-bash

Example：https://github.com/codecov/example-php

Example: https://github.com/khs1994-php/tencent-ai

<!--more-->

由于网站部分资源从 google 加载，国内可能访问不畅！

本文以 PHP 为例。

前置知识：

* PHPUnit

`Codecov` 本身不做构建，其只是分析代码报告，然后展示出来，所以还是得配合 `Travis CI` 等构建工具来使用。

`Travis CI` 进行代码测试，生成报告

使用命令行上传这个报告

`Codecov` 分析报告，然后展示出来

```bash
# 生成报告命令

$ vendor/bin/phpunit --coverage-clover=coverage.xml

$ export CODECOV_TOKEN=XXX

# Travis CI 等 Codecov 支持的 CI 工具无需设置 Token，若在本地测试需要设置 Token
# 注意此步不要写在构建脚本中，这里列出只是方便告诉大家需要的环境变量，具体的 Token 值请在仓库的设置中查看

# 使用上传脚本，上传测试报告，当然也提供其他语言的脚本，自行查看文档

$ bash <(curl -s https://codecov.io/bash)
```

在 CI 的 Docker 中如何使用？

* https://docs.codecov.io/docs/testing-with-docker

```bash
# request codecov to detect CI environment to pass through to docker

$ ci_env=`bash <(curl -s https://codecov.io/env)`
$ docker run $ci_env ...

# exec tests

$ bash <(curl -s https://codecov.io/bash)
```

## More Information

* https://segmentfault.com/a/1190000007221668

* https://blog.csdn.net/gdky005/article/details/73330337
