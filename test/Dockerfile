FROM scratch
# 语法 COPY|ADD <src> <dst>
# 如果<src>是一个常见的压缩格式，如tar.gz。那么它会被解压
ADD alpine-minirootfs-3.10.3-x86_64.tar.gz /
#更新Alpine的软件源为国内（清华大学）的站点，因为从默认官源拉取实在太慢了。。。
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories \
#Alpine Docker为了精简体积，是没有安装bash，安装完也只有10.2M
&& apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
CMD ["/bin/sh"]