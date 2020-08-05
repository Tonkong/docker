#!/bin/bash

# 先创建镜像 Dockerfile
dir=$(
  cd "$(dirname "$0")"
  pwd
)
echo $dir
imageName="rabbitmq:37"
containerName="rabbitmq"
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
echo $imageName

docker run --name=$containerName \
  -p 5672:5672 \
  -p 15671:15671 \
  -p 15672:15672 \
  -p 15674:15674 \
  --env TZ=Asia/Shanghai \
  --network dbnet \
  --restart always \
  -v $dir/data:/var/lib/rabbitmq/mnesia \
  -d $imageName
docker exec -it $containerName /bin/sh
