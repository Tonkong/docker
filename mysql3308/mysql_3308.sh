#!/bin/bash
dir=$(cd "$(dirname "$0")"; pwd)
echo $dir
docker run --name=mysql3308 \
--env MYSQL_ROOT_HOST=% \
--env MYSQL_ROOT_PASSWORD=2015 \
--env TZ=Asia/Shanghai \
-p 3308:3308 \
#--mount type=bind,src=$dir/my_3308.cnf,dst=/etc/my.cnf \
--mount type=bind,src=$dir/data_3308,dst=/var/lib/mysql \
--mount type=bind,src=$dir/log_3308,dst=/var/log/mysql \
--network dbnet \
-d mysql/mysql-server:5.7.28
# 镜像为官方镜像

# 修改配置文件后可restart重启
