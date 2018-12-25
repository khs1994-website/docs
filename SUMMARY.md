# Summary

* [README](README.md)
* [CI/CD](ci/README.md)
    * [Style CI](ci/styleci/README.md)     
    * [Jenkins](ci/jenkins/README.md)
    * [Drone](ci/drone/README.md)
        * [用法](ci/drone/usage.md)
        * [GitBook](ci/drone/gitbook.md)
        * [Hexo](ci/drone/hexo.md)
        * [PHP](ci/drone/php.md)
    * [Travis CI](ci/travis-ci/README.md)
        * [GitBook](ci/travis-ci/gitbook.md)
        * [Hexo](ci/travis-ci/hexo.md)
    * [Codecov](ci/codecov/README.md)    

## 缓存

* [缓存](cache/README.md)
    * [Compare](cache/compare.md)
    * [Memcached](cache/memcached/README.md)
        * [使用详解](cache/memcached/quickstart.md)
    * [Redis](cache/redis/README.md)
        * [配置文件](cache/redis/config.md)
        * [持久化](cache/redis/persistence.md)
        * [主从复制](cache/redis/replication.md)
        * [Sentinel](cache/redis/sentinel.md)
        * [Cluster](cache/redis/cluster.md)
        * [key 操作](cache/redis/key.md)
        * [string 类型](cache/redis/string.md)            
        * [hash 类型](cache/redis/hash.md)
        * [list 类型](cache/redis/list.md)
        * [set 类型](cache/redis/set.md)
        * [sorted set 类型 zset](cache/redis/sorted-set.md)
        * [其他](cache/redis/other.md)

## 数据库

* 数据库
    * [MongoDB](database/mongodb/README.md)
        * [配置文件](database/mongodb/config.md)
        * [使用详解](database/mongodb/quickstart.md)
    * [MySQL](database/mysql/README.md)
        * [远程登录](database/mysql/remote.md)
        * [配置文件](database/mysql/config.md)
        * [数据类型](database/mysql/types.md)
        * [ALTER](database/mysql/alter.md)
        * [CREATE](database/mysql/create.md)
        * [DELETE](database/mysql/delete.md)
        * [DROP](database/mysql/drop.md)
        * [SELECT](database/mysql/select.md)
        * [INSERT_UPDATE](database/mysql/insert_update.md)
        * [索引](database/mysql/mysql-index.md)
        * [函数](database/mysql/function.md)
        * [mysqldump 命令](database/mysql/mysqldump.md)
        * [主从配置](database/mysql/cluster.md)
        * [存储引擎](database/mysql/engine.md)
        * [NoSQL](database/mysql/nosql.md)
    * [PostgreSQL](database/postgresql/README.md)
        * [配置文件](database/postgresql/config.md)

## Docker

* [Docker](docker/README.md)
    * [Rkt](docker/rkt/README.md)
    * [CoreOS](docker/coreos/README.md)
        * [Ignition](docker/coreos/ignition.md)
        * [Ignition v2.2](docker/coreos/configuration-v2_2-experimental.md)
        * [安装内网服务器](docker/coreos/install-server.md)
        * [CoreOS PXE 启动](docker/coreos/boot-pxe-new.md)
        * [CoreOS iPXE 启动](docker/coreos/boot-ipxe.md)
        * [CoreOS 硬盘安装](docker/coreos/install-disk-new.md)
        * [CoreOS 系统升级](docker/coreos/update.md)
        * [etcd](docker/coreos/etcd.md)
        * [fleet 废弃](docker/coreos/migrating-from-fleet-to-kubernetes.md)
    * [概念总览](docker/overview.md)    
    * [Docker 守护进程](docker/dockerd.md)    
    * [Docker Machine](docker/machine.md)
    * [Docker Registry v2](docker/registry.md)
    * [Docker Registry v2 配置文件详解](docker/registry-config.md)
    * [Docker Compose](docker/compose.md)
    * [Docker Compose 中国镜像](docker/compose-mirror.md)
    * [Swarm mode](docker/swarm.md)
    * [Docker 网络](docker/network.md)
    * [Docker 数据管理](docker/manage-application-data.md)
    * [Dockerfile 最佳实践](docker/dockerfile.md)
    * [Docker 镜像云端构建](docker/build-image.md)
    * [Dockerfile 多阶段构建](docker/multistage-builds.md)
    * [Docker Cloud](docker/cloud.md)
    * [Docker Store](docker/store.md)
    * [开发环境](docker/development.md)
    * [生产环境](docker/production.md)
    * [Docker LNMP 配置](docker/lnmp.md)
    * [LinuxKit](docker/linuxkit.md)
    * [清理](docker/prune.md)
    * [WSL Docker CLI](docker/wsl-run-docker-cli.md)
    * [Docker 常见问题](docker/issues.md)
    * [Docker 从入门到实践](docker/docker_practice.md)
    * [Mac Docker API](docker/mac_docker_api.md)

## Kubernetes

* [Kubernetes](docker/k8s/README.md)
    * [手动部署](docker/k8s/install,md)
    * [kubectl 国内镜像](docker/k8s/kubectl-cn-mirror.md)
    * [Docker for Desktop k8s](docker/docker-with-k8s.md)
    * [包管理工具 Helm](docker/k8s/helm.md)
    * [Minikube](docker/k8s/minikube.md)

## CLOUD

* CLOUD
    * [Minio](cloud/minio.md)

## Linux

* [Linux](linux/README.md)
    * [Crontab](linux/crontab.md)
    * [CentOS7 初始化配置](linux/centos.md)
    * [Ubuntu 初始化配置](linux/ubuntu.md)
    * [Fedora](linux/fedora.md)
    * [Alpine](linux/alpine.md)
    * [下载相关](linux/download.md)
    * [网络相关](linux/network/README.md)
    * Server
        * [邮件服务器](linux/server/email.md)
        * [自动部署](linux/server/pxe.md)
        * [DHCP](linux/server/dhcp.md)
        * [DNS](linux/server/dns.md)
    * [SHELL 脚本](linux/shell/function.md)
        * [date](linux/shell/date.md)
        * [echo、read](linux/shell/echo-read.md)
        * [if、case](linux/shell/if-case-etc.md)
        * [set](linux/shell/set.md)
        * [patch](linux/shell/patch.md)  
    * [SSH](linux/ssh/README.md)
        * [SSH 隧道与端口转发内网穿透](linux/ssh/proxy.md)
    * [systemd 详解](linux/systemd/README.md)
        * [timer](linux/systemd/timer.md)
        * [journal](linux/systemd/journal.md)
    * 包管理工具
        * [apt](linux/package_management/apt.md)
        * [Alpine apk](linux/package_management/apk.md)
        * [RedHat yum](linux/package_management/yum.md)
    * SSL
       * [OpenSSL 加密文件](linux/ssl/file-enc.md)
       * [HTTPS](linux/ssl/https/README.md)
       * [自签名 TLS 证书](linux/ssl/https/self-signed-ssl-certificates.md)
       * [cfssl](linux/ssl/cfssl.md)
    * [fish shell](linux/fish-shell/README.md)
       * [命令补全](linux/fish-shell/completion.md)
    * [Ansible](linux/ansible.md)   

## Git

* [Git](git/README.md)
    * [GitHub](git/github/README.md)
        * [API](git/github/api.md)
    * [GitBook](git/gitbook.md)
    * [Gitlab Docker 安装配置](git/gitlab.md)
    * [Gogs Docker 安装配置](git/gogs.md)
    * [国内 Git](git/cn.md)
    * [Git LFS](git/lfs.md)
    * [Git SVN 一起使用](git/git-svn.md)
    * [SVN](git/svn.md)

## HTML

* [HTML](html/README.md)
    * [HTML 表单](html/form.md)
    * [DOM](html/dom.md)

## CSS

* [CSS](html/css/README.md)
    * [预处理器](html/css/less_sass.md)

## EcmaScript

* [JavaScript](html/js/README.md)
    * [HTML](html/js/html.md)
    * [对象](html/js/object.md)
    * [AJAX](html/js/ajax.md)
    * [jQuery](html/js/jquery.md)
    * [ESLint](html/js/eslint.md)
    * [webpack](html/js/webpack.md)
    * [面向对象](html/js/oop.md)

* [TypeScript](html/js/typescript/README.md)   

## Node.js

* [Node.js](nodejs/README.md)
    * [npm](nodejs/npm.md)
    * [yarn](nodejs/yarn.md)    

## Python

* [Python](python/README.md)
    * [基本语法](python/basic.md)
    * [OOP](python/oop.md)
    * [Django](python/django/README.md)
    * [MySQL](python/mysql.md)    

## Macos

* [macOS](macos/README.md)
    * [Homebrew](macos/brew.md)
    * [gdb](macos/gdb.md)
    * [macOS 背后的故事上](macos/story.md)
    * [macOS 背后的故事下](macos/story2.md)
    * [macOS 背后的故事 补充](macos/story3.md)

## 工具软件

* 工具软件
    * [火狐常用设置](tools/firefox.md)
    * [视频下载工具 you-get](tools/youget.md)
    * [Vim](tools/vim.md)
    * [Atom](tools/atom.md)
    * [aria2 下载工具](tools/aria2.md)
    * [sqlectron SQL 图形客户端](tools/sqlectron.md)
    * [Postman](tools/postman.md)
    * [EditorConfig](tools/editorconfig.md)
    * [终端录制工具](tools/terminal-rec.md)
    * [跨平台终端 Hyper](tools/hyper.md)
* [Raspberry Pi3](raspberry-pi3/README.md)
    * [Docker](raspberry-pi3/docker.md)
    * [arm64v8](raspberry-pi3/arm64v8.md)
    * [编译内核](raspberry-pi3/build-kernel.md)
    * [MySQL](raspberry-pi3/mysql.md)
* [虚拟化](vm/README.md)
    * [UbuntuEFI 设置](vm/ubuntu-efi.md)
    * [Hyper-V](vm/hyperv/README.md)

## CMS

* CMS
    * [Hexo](cms/hexo/README.md)
    * [Typecho 使用详解](cms/typecho/README.md)
    * [WordPress 使用详解](cms/wordpress/README.md)
    * [Netlify](cms/netlify.md)
    * [pages](cms/pages.md)

## 其他

* 其他
    * Android
        * [AndroidStudio Linux](other/android/android-studio-linux32.md)
        * [Android 依赖服务器 Nexus](other/android/nexus.md)
    * [C](other/c/README.md)
    * [Java](other/java/README.md)
        * [Gradle](other/java/gradle.md)
        * [Maven 常用配置](other/java/maven.md)
    * [iOS](other/ios/README.md)
    * [Swift](other/swift/README.md)
    * [PowerShell](other/powershell/README.md)   
* [PHP](php/readme.md)
* [Golang](golang/README.md)
