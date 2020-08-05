#!/bin/bash
# shellcheck disable=SC2164
dir=$(cd "$(dirname "$0")"; pwd)
echo $dir
docker run --name mysql \
--privileged=true \
#-v $dir/data:/var/lib/mysql \
--user 1000:1000 \
--mount type=bind,src=$dir/conf/my.cnf,dst=/etc/my.cnf \
-v $dir/log:/var/log \
--env MYSQL_ROOT_HOST=% \
--env MYSQL_ROOT_PASSWORD=2015 \
--env TZ=Asia/Shanghai \
-p 3308:3306 \
--network dbnet \
-d mysql/mysql-server:5.7.29 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci


#If you know the permissions of your directory are already set appropriately (such as running against an existing database, as described above) or you have need of running mysqld with a specific UID/GID, it is possible to invoke this image with --user set to any value (other than root/0) in order to achieve the desired access/configuration:
#
#$ mkdir data
#$ ls -lnd data
#drwxr-xr-x 2 1000 1000 4096 Aug 27 15:54 data
#$ docker run -v "$PWD/data":/var/lib/mysql --user 1000:1000 --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag


#-v $dir/data:/var/lib/mysql \
#-v $dir/log:/var/log/mysql \
#-v $dir/conf:/etc/mysql/conf.d \
#-v $dir/data:/var/lib/mysql \

#docker run -v "/mnt/hgfs/E/docker/mysql3306/data":/var/lib/mysql --name mysql -e MYSQL_ROOT_PASSWORD=2015 -d mysql/mysql-server:5.7.29
#-v $dir/conf:/etc/mysql/my.cnf.d \
#-v $dir/data:/var/lib/mysql \
