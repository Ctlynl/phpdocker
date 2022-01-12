FROM nginx:stable-alpine

LABEL maintainer="make835215945@163.com"
LABEL version="1.0"
LABEL description="nginx web service"

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000

# 安装日志切割文件
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
	&& apk upgrade && apk --no-cache add logrotate openssl;

RUN PHP_UPSTREAM="upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" \
 	&& echo $PHP_UPSTREAM > /etc/nginx/conf.d/upstream.conf \
    && rm -rf /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/

EXPOSE 80
EXPOSE 443