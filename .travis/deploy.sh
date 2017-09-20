#!/bin/bash
git clone -b gitbook $REPO repo
cd repo
git ls-files | while read file; do touch -d $(git log -1 --format="@%ct" "$file") "$file"; done
docker run -dit -v $PWD:/tmp/gitbook-src khs1994/gitbook:1.0.0
docker ps -a
~/build/khs1994-website/docs/.travis/docker-status.sh
docker ps -a
docker logs gitbook
# Clone the repository
git clone -b "$DEPLOY_BRANCH" "$REPO" .deploy_git
if [ ! $? = 0 ];then
  #不存在
  echo -e "\033[32mINFO\033[0m  BRANCH NOT exist"
  mkdir .deploy_git
  cd .deploy_git
  git init
  git remote add origin $REPO
  cd ..
else
  #存在
  echo -e "\033[32mINFO\033[0m  BRANCH exist"
  rm -rf .deploy_git/*
fi
# Deploy to GitHub and aliyun
sudo cp -a _book/* .deploy_git/
cd .deploy_git
git remote add aliyun "$REPO_ALIYUN"
git checkout -b "$DEPLOY_BRANCH"
git add .
COMMIT=`date "+%F %T"`
git commit -m "Travis CI Site updated: $COMMIT"
git push -f aliyun "$DEPLOY_BRANCH"
git push -f origin "$DEPLOY_BRANCH"
cd ~
sudo rm -rf repo
