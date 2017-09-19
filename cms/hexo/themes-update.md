---
title: Hexo 主题更新问题
date: 2016-03-02 12:00:00
updated:
comments: true
tags:
- Hexo
categories:
- CMS
- Hexo
---

Hexo next 主题从 GitHub clone 到主题文件夹，如果要被项目 Git 跟踪，就得删除主题的 .git 文件夹（可以引入 子 git ,没有尝试过，这里不再说明）  
这样问题是主题更新比较麻烦，我通过shell脚本实现`无痛`升级。

<!--more-->

```bash

cd themes
rm -rf next/.git _config.yml
# 备份配置文件
cp next/_config.yml .
# 恢复默认配置文件
mv _config.yml.default next/_config.yml
cd next
if [ ! -f "git.tar.gz" ];then
  echo -e "\033[32mINFO\033[0m  git.tar.gz NOT existe"
  #git.tar.gz不存在
  git init
  git remote add origin git@github.com:iissnan/hexo-theme-next.git
  git add .
  #git commit -m "first"
else
echo -e "\033[32mINFO\033[0m  git.tar.gz existe"
tar -zxf git.tar.gz
fi
echo -e "\033[32mINFO\033[0m  ALL branch: "
echo
git branch -av
#git add .
#git commit -m "first"
echo -e "\033[32mINFO\033[0m  fetch origin..."
# 读取远程
git fetch origin
echo -e "\033[32mINFO\033[0m  fetch reset..."
# 强制覆盖
git reset --hard origin/master
# 备份默认配置文件
mv _config.yml ../_config.yml.default
# 恢复配置文件
cp ../_config.yml .
# 打包 .git
tar -zcf git.tar.gz .git
echo -e "\033[32mINFO\033[0m  rm .git folder..."
rm -rf .git

```

>本命令不再更新，最新记录请访问 GitHub

我自己写的脚本：https://raw.githubusercontent.com/khs1994/khs1994.github.io/hexo/khs1994.hexo
