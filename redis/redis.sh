#!/bin/bash

# 先创建镜像 Dockerfile
dir=$(
  cd "$(dirname "$0")"
  pwd
)
echo $dir
imageName="redis:4014"
containerName="redis"
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
docker build -t $imageName .

echo "开始创建容器"

# 创建容器
docker run --name=$containerName \
  -p 6379:6379 \
  -v $dir/etc:/usr/local/etc/redis \
  -v /etc/timezone:/etc/timezone \
  -v /etc/localtime:/etc/localtime \
  -v $dir/data:/data \
  --network dbnet \
  --restart always \
  -d $imageName

#docker exec -it $containerName /bin/sh