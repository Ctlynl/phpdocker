FROM php:8.1.6-cli-alpine3.14

LABEL Maintainer="make835215945@163.com"
LABEL Version="1.0"
LABEL Description="php-cli8.1.6 composer cron supervisor swoole event socket"

#set镜像源
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories;

ARG PHP_REDIS_FILE_NAME
ARG MONGODB_FILE_NAME
ARG SWOOLE_FILE_NAME
ARG EVENT_FILE_NAME
ARG GD_FREE_TYPE_NAME

COPY ./ext/ /php-ext/

RUN docker-php-source extract;

ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf

RUN apk add --no-cache \
	$PHPIZE_DEPS \
	libevent-dev \
	libpng-dev \
	icu-dev \
	bzip2-dev\
	gmp-dev \
	libzip-dev \
	libpq \
	gettext-dev \
	aspell-dev \
	libxslt-dev \
	openssl-dev \
	c-ares-dev \
	curl-dev \
	freetype-dev;

RUN find /php-ext/ -type f \( -name "*.tgz" -o -name "*.tar.gz" \) | xargs -i tar -zxf {} -C /usr/src/php/ext/;

	# 安装php扩展
RUN /usr/src/php/ext/${GD_FREE_TYPE_NAME}/configure --prefix=/usr/local/freetype \
&& make && make install && docker-php-ext-configure gd --with-freetype=/usr/local/freetype;

RUN docker-php-ext-install -j2 bcmath bz2 calendar dba exif gd gettext gmp intl mysqli pcntl pspell shmop \
	soap sockets sysvmsg sysvsem sysvshm xsl pdo_mysql zip ${PHP_REDIS_FILE_NAME} ${MONGODB_FILE_NAME} \
	# 安装envent扩展为什么要单独安装是因为evnet需要sockets扩展 但是在conf.d文件引入的ini配置文件排序是在sockets在上面
	&& docker-php-ext-install -j2 --ini-name zz-event.ini ${EVENT_FILE_NAME} \
	# 安装swoole扩展
	&& docker-php-ext-configure $SWOOLE_FILE_NAME \
		--enable-openssl \
		--with-openssl-dir=/usr/include/openssl \
		--enable-http2 \
		--enable-swoole-json \
		--enable-swoole-curl \
		--enable-cares \
		--enable-mysqlnd \
		--enable-debug \
	&& docker-php-ext-install -j3 $SWOOLE_FILE_NAME;

# 移除无用
RUN docker-php-source delete \
	&& rm -rf /php-ext \
	&& rm -rf ${PHP_INI_DIR}/php.ini-development \
	&& rm -rf ${PHP_INI_DIR}/php.ini-production;

#设置crontab
ARG CRONTAB_CONF_DIR=/crontab
COPY ./crontab ${CRONTAB_CONF_DIR}
COPY ./start.sh /usr/bin/start.sh
RUN chmod 744 /usr/bin/start.sh && start.sh ${CRONTAB_CONF_DIR}

#安装composer composer global安装的插件默认放在用户的根目录 .composer文件夹
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# 安装守护进程管理工具
RUN apk add --no-cache supervisor;

# 安装其他工具
RUN apk add --no-cache htop vim pstree;

# 解决 php iconv扩展 Wrong charset, conversion from GB2312 to UTF-8//IGNORE' 报错
RUN apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.12/community/ --allow-untrusted gnu-libiconv=1.15-r2
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

WORKDIR /var/www