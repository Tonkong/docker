#!/bin/bash

# 先创建镜像 Dockerfile
dir=$(
  cd "$(dirname "$0")"
  pwd
)
echo $dir
imageName="nginx:1161"
containerName="nginx1161"
getComtainer=$(docker ps -a -q -f name=$containerName)
if [ $getComtainer ]; then
  # 暂停、删除已有容器，并删除镜像
  docker stop $containerName
  docker rm $containerName
fi

# 是否重新构建镜像
#docker rmi $imageName
#
## 创建镜像
#cd $dir
#echo "开始创建镜像"
#read -p "按回车键继续:"
#echo `pwd`
#docker build -t $imageName .

echo "开始创建容器"
echo $imageName
read -p "按回车键继续:"

# 创建容器
docker run --name=$containerName \
  -v /mnt/hgfs/E/docker/nginx/logs:/usr/local/nginx/logs \
  -v /mnt/hgfs/E/docker/nginx/nginx.conf:/usr/local/nginx/nginx.conf \
  -v /mnt/hgfs/E/docker/nginx/fastcgi.conf:/usr/local/nginx/fastcgi.conf \
  -v /mnt/hgfs/E/docker/nginx/conf.d:/usr/local/nginx/conf.d \
  -v /mnt/hgfs/E/sos:/usr/share/nginx \
  -p 80:80 \
  -p 443:443 \
  --network dbnet \
  -d \
  $imageName

docker exec -it $containerName /bin/sh
#  --restart always \
# /mnt/hgfs/E/sos  宿主主机的目录
