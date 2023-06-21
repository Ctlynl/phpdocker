<h1 align="center"> phpdocker </h1>

<p align="center"> 🌈 基于docker实现的PHP-FPM和PHP+Swoole环境</p>
<p align="center">PHP7.4 PHP8+cli PHP-FPM Swoole mysql redis mongodb nginx nginxssl</p>

## 安装

```shell
cp .env.example .env
```

### nginx配置
```html
配置文件在nginx/sites目录
nginx/cert ssl证书目录
```

### mysql配置
```html
mysql/my.cnf MysqlServer配置文件
mysql/docker-entrypoint-initdb.d文件夹下为mysql默认容器启动执行的脚本 
```

### mongodb配置
```html
mongo/mongod.conf mongoServer配置文件
mongo/docker-entrypoint-initdb.d文件夹下为mongo默认容器启动执行的脚本 
```
### PHP-FPM配置
```html
php-fpm/config 为配置文件夹
php-fpm/ext 为PHP自定义扩展文件夹（例如redis扩展包） 
```

### Redis
```html
redis/redis.conf 配置文件 
```

### workspace Swoole
```html
 workspace/crontab 计划任务文件夹
 workspace/ext 为PHP自定义扩展文件夹
 workspace/php.ini PHP配置文件
 workspace/start.sh 容器启动执行的脚本
```

### workspace8 Swoole
```html
 workspace8/crontab 计划任务文件夹
 workspace8/ext 为PHP自定义扩展文件夹
 workspace8/php.ini PHP配置文件
 workspace8/start.sh 容器启动执行的脚本
```

## LICENSE MIT