#!/bin/bash

git ls-files | while read file; do touch -d $(git log -1 --format="@%ct" "$file") "$file"; done

docker run -it --rm \
  -v $PWD:/srv/gitbook-src \
  khs1994/gitbook

sudo chmod -R 777 _book

cd _book

git init
git remote add origin "$REPO"
git remote add aliyun "$REPO_ALIYUN"
git add .
COMMIT=`date "+%F %T"`
git commit -m "Travis CI Site updated: $COMMIT"
git push -f aliyun master:"$DEPLOY_BRANCH"
git push -f origin master:"$DEPLOY_BRANCH"

cd ..

docker build -t khs1994/docs:latest .

docker tag khs1994/docs:latest khs1994/doc:latest

docker push khs1994/docs:latest

docker push khs1994/doc:latest
