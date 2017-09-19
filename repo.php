#!/usr/bin/env php
<?php
$version="v0.0.1";
$path=getcwd();
#读取执行命令的文件夹中的repo.json
$json_path=$path."/repo.json";
$json=file_get_contents("$json_path");
$array=json_decode($json, true);
//var_dump($array);
switch ($argv[1]) {
  case 'path':
    echo $json_path;
    break;
  case 'branch':
    echo $array['branch'];
    break;
  case 'deploy-branch':
    echo $array['deploy-branch'];
    break;
  case 'aliyun':
    if (array_key_exists('aliyun', $array['repo'])) {
        echo $array['repo']['aliyun'];
    } else {
        echo "404\n";
    };
    break;
  case 'github':
    if (array_key_exists('github', $array['repo'])) {
        echo $array['repo']['github'];
    } else {
        echo "404\n";
    };
    break;
  default:
    # code...
    echo <<<EOF
$version

path             : repo.json 路径
branch           : 主分支
deploy-branch    : 部署分支
aliyun           : 阿里云 仓库
github           : GitHub 仓库

EOF;
    break;
}
