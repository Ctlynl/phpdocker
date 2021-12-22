ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine3.14

LABEL maintainer="make835215945@163.com"
LABEL version="1.0"
LABEL description="php-fpm"

ARG PHP_REDIS_FILE_NAME=redis-5.1.1
ARG MONGODB_FILE_NAME=mongodb-1.11.1

#set镜像源
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

COPY ./ext /php-ext/
COPY ./config/php-fpm.conf /usr/local/etc/
COPY ./config/www.conf /usr/local/etc/php-fpm.d

RUN docker-php-source extract;

WORKDIR /usr/local/etc

ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c

RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
    && apk add --no-cache libpng-dev icu bzip2-dev gmp-dev libzip-dev libpq libxslt-dev gettext-dev \
	&& find /php-ext/ -name "*.tgz"|xargs -i tar -zxf {} -C /usr/src/php/ext/ \
	&& docker-php-ext-install -j2 ${PHP_REDIS_FILE_NAME} ${MONGODB_FILE_NAME} pdo_mysql bcmath gd gmp pdo_pgsql \
	bz2 iconv zip mysqli xsl gettext sysvmsg sysvsem sysvshm xmlrpc \
	&& apk del -f .build-deps \
	&& docker-php-source delete \
	&& rm -rf /php-ext \
	&& rm -rf ./php/php.ini-development \
	&& rm -rf ./php/php.ini-production \
	&& rm -rf ./php-fpm.conf.default \
	&& rm -rf ./php-fpm.d/www.conf.default;

WORKDIR /var/www