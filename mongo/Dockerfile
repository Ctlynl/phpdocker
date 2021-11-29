FROM mongo:4.4.10-rc0-focal

LABEL maintainer="make835215945@163.com"
LABEL version="1.0"
LABEL description="mongodb"

COPY mongod.conf /usr/local/etc/mongo/mongod.conf

VOLUME /data/db /data/configdb

CMD ["mongod", "-f", "/usr/local/etc/mongo/mongod.conf"]

EXPOSE 27017