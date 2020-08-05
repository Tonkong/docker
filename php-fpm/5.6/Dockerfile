FROM php:5.6.37-fpm-alpine3.7
COPY phpredis-3.1.6.tar.gz /usr/src/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk update \
    && apk add --no-cache libmcrypt-dev freetype-dev libjpeg-turbo-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mcrypt pdo_mysql bcmath pcntl \
    && mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/3.1.6.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis \
    && cd /usr/src/ \
    && tar zxvf phpredis-3.1.6.tar.gz \
    && rm -f phpredis-3.1.6.tar.gz \
    && docker-php-ext-configure /usr/src/phpredis-3.1.6 --enable-redis \
    && docker-php-ext-install /usr/src/phpredis-3.1.6 \
    && rm -r /usr/src/phpredis-3.1.6
    # Install composer
#    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
EXPOSE 9009
