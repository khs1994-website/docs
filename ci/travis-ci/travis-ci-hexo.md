---
title: Hexo + Travis CI 实践（整合优化）
date: 2017-07-31 13:00:00
updated:
comments: true
tags:
- Hexo
- CI
- Travis CI
categories:
- CI
- Travis CI
---

使用`Travis CI`之前：
* 本地编写`source/*.md`
* `hexo g`本地预览
* `hexo d`推送到`GitHub`和`aliyun`
* `手动`完成后续操作：
* 登录到服务器，`pull`到网站根目录，等后续操作。

<!--more-->

使用`Travis CI`：
* 本地编写`source/*.md`
* `hexo g`本地预览
* 将部署文件推送到`GitHub`和`aliyun`
* `自动`完成后续操作：
* `Travis CI`云端生成`HTML`,并将其推送到`GitHub`和`aliyun`仓库的`master`分支
* GitHub`webhooks`通知服务器，服务器将`aliyun`仓库的代码`强制pull`
* 调用`百度站长平台`完成URL`主动推送`
* 调用`微信公众平台`模板消息API完成消息提醒

# 配置

[GitHub仓库](https://github.com/khs1994/khs1994.github.io) `hexo`存放部署文件，`master`存放HTML文件。

> `khs1994.github.io`(用户名.github.io)仓库的`Pages`只能使用`master`分支

`命令行工具`加密SSH私钥。（使用`SSH`得到GitHub操作权限，也可以通过`github Token`）  
`Travis CI`网站开启项目部署。  

# 示例文件

[`.travis.yml`](https://github.com/khs1994/khs1994.github.io/blob/hexo/.travis.yml)  


# 相关链接

* http://blog.csdn.net/woblog/article/details/51319364  
