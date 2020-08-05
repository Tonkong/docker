#!/bin/bash

# 先创建镜像 Dockerfile
dir=$(
  cd "$(dirname "$0")"
  pwd
)
echo $dir
imageName="postfixadmin:322"
containerName="postfixadmin"
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
docker build --force-rm -t $imageName .

echo "开始创建容器"

# 创建容器

docker run -e POSTFIXADMIN_DB_TYPE=mysqli \
           -e POSTFIXADMIN_DB_HOST=mysql3308 \
           -e POSTFIXADMIN_DB_PORT=3308 \
           -e POSTFIXADMIN_DB_USER=tang \
           -e POSTFIXADMIN_DB_PASSWORD=2015 \
           -e POSTFIXADMIN_DB_NAME=postfixadmin \
           --name $containerName \
           -p 8080:80 \
           --network dbnet \
           -d $imageName

#docker exec -it $containerName /bin/sh

# 文档：http://postfixadmin.sourceforge.net/
# 安装完成后访问地址、初始化
#http://localhost:8080/setup.php
# Setup password: tangkang123
# 管理员：tangkang@live.cn)
# 密码：tangkang123

