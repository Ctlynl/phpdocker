FROM redis:5.0.14-alpine3.14

LABEL maintainer="make835215945@163.com"
LABEL version="1.0"
LABEL description="redis"

COPY ./redis.conf /usr/local/etc/redis/redis.conf

VOLUME /data

EXPOSE 6379

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]