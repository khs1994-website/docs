---
title: CocoaPods 安装配置
date: 2016-07-06 13:00:00
updated:
comments: true
tags:
- iOS
categories:
- Other
- iOS
---

首先安装配置好 `ruby`，`CocoaPods` 需要 `Ruby` 的版本大于 2.2.2，不然会报错：`Error installing pods: activesupport requires Ruby version >= 2.2.2`。

macOS 默认自带是 2.0 版本，所以需要升级。

<!--more-->

```bash
$ brew update
$ brew install ruby
```

## 删除 gem 源

```bash
$ gem sources --remove https://rubygems.org/

# 据说淘宝源已停止维护，以前添加过淘宝源的删除

$ gem sources --remove https://ruby.taobao.org/
```

## 添加 gem 国内源

```bash
$ gem sources -a https://gems.ruby-china.org/
$ gem sources -l

*** CURRENT SOURCES ***
https://gems.ruby-china.org/

#出现以上提示说明添加成功
```

# 安装

```bash
$ sudo gem install -n /usr/local/bin cocoapods
```

* 若Xcode为预览版 ，在命令后边添加 `--pre`

## 查看版本

```bash
$ pod --version
```

```bash
$ sudo xcode-select --switch /Applications/Xcode.app
```

## 克隆仓库

```bash
$ pod setup
# 本质是从 GitHub 克隆代码，一些国内镜像源停止更新，通过修改 host 加速 GitHub
```

## 测试

```bash
$ pod search AFNetworking
```

可能出现错误

```bash
[!] Unable to find a pod with name, author, summary, or description matching `AFNetworking`
```

解决方法

```bash
$ rm ~/Library/Caches/CocoaPods/search_index.json
```

# 使用

## 切换到 Xocde 项目文件夹

```bash
$ cd Desktop/swiftweahter
```

## 编辑配置文件

```bash
$ vi Podfile

platform :ios, '10.0'

use_frameworks!

target 'MyApp' do
  pod 'AFNetworking', '~> 2.6'   
  pod 'ORStackView', '~> 3.0'
  pod 'SwiftyJSON', '~> 2.3'
end

#输入以上内容，target '＊＊＊＊' do 单引号内填入你自己的项目名称
```
## 安装

```bash
$ pod install --verbose --no-repo-update
```

## 打开项目

打开项目用`CocoaPodsDemo.xcworkspace`

# 更新

```bash
$ sudo gem update --system
```

# 卸载

```bash
#待补充
```

# 相关链接

* http://www.cocoachina.com/bbs/read.php?tid=193398&page=1  
* http://blog.csdn.net/ralbatr/article/details/39082937  
* http://www.jianshu.com/p/2ef8a38416c4
