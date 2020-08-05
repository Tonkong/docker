#!/bin/bash

# 先创建镜像 Dockerfile
dir=$(
  cd "$(dirname "$0")"
  pwd
)
echo $dir
imageName="php:56"
containerName="php56"
getComtainer=$(docker ps -a -q -f name=$containerName)
if [ $getComtainer ]; then
  # 暂停、删除已有容器，并删除镜像
  docker stop $containerName
  docker rm $containerName
fi

docker rmi $imageName

# 创建镜像
cd $dir
echo "开始创建镜像"
read -p "按回车键继续:"
echo pwd
docker build -t $imageName .

echo "开始创建容器"
read -p "按回车键继续:"

# 创建容器
docker run --name=$containerName \
  -p 9009:9009 \
  -p 9503:9502 \
  -v $dir/php-fpm.d:/usr/local/etc/php-fpm.d \
  -v $dir/conf.d:/usr/local/etc/php/conf.d \
  -v /Users/tangkang/sos/php:/var/www \
  --network dbnet \
  --restart always \
  -d $imageName

docker exec -it $containerName /bin/sh