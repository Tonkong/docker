#!/bin/bash
containerName="nexus3"
imageName="sonatype/nexus3"
# 创建容器
docker run --name=$containerName \
  -p 8081:8081 \
  -p 8082:8082  \
  -p 8083:8083  \
  -p 8084:8084  \
  -p 8085:8085   \
  -v /mnt/hgfs/E/docker/nexus3/nexus-data:/nexus-data \
  --network dbnet \
  -d \
  $imageName

docker exec -it $containerName /bin/sh
#  --restart always \
# /mnt/hgfs/E/sos  宿主主机的目录

# 安装参考 https://www.jianshu.com/p/77af52a75ad8
# 密码重置为 admin123

# maven 仓库使用：https://blog.csdn.net/daihanguang123/article/details/80774343