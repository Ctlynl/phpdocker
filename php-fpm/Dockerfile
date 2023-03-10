ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine3.14

LABEL maintainer="make835215945@163.com"
LABEL version="1.0"
LABEL description="php-fpm"

ARG PHP_REDIS_FILE_NAME=redis-5.1.1
ARG MONGODB_FILE_NAME=mongodb-1.11.1
ARG GD_FREE_TYPE_NAME=freetype-2.13.0

#set镜像源
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

COPY ./ext /php-ext/

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
    && apk add --no-cache freetype-dev libpng-dev icu bzip2-dev gmp-dev libzip-dev libpq libxslt-dev gettext-dev \
	&& find /php-ext/ -type f \( -name "*.tgz" -o -name "*.tar.gz" \) | xargs -i tar -zxf {} -C /usr/src/php/ext/ \
	&& /usr/src/php/ext/${GD_FREE_TYPE_NAME}/configure --prefix=/usr/local/freetype && make && make install \
	&& docker-php-ext-configure gd --with-freetype=/usr/local/freetype \
	&& docker-php-ext-install -j2 ${PHP_REDIS_FILE_NAME} ${MONGODB_FILE_NAME} pdo_mysql bcmath gd gmp pdo_pgsql \
	bz2 iconv zip mysqli xsl gettext sysvmsg sysvsem sysvshm xmlrpc gettext \
	&& apk del -f .build-deps \
	&& docker-php-source delete \
	&& rm -rf /php-ext \
	&& rm -rf ./php/php.ini-development \
	&& rm -rf ./php/php.ini-production \
	&& rm -rf ./php-fpm.conf.default \
	&& rm -rf ./php-fpm.d/www.conf.default;

WORKDIR /var/www