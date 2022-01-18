# phpdocker
php-7.4 swoole mysql redis mongodb php-cli7.4 nginx nginxssl

1、 cp .env.example .env
2、配置.env文件
3、nginx配置文件：nginx/sites，ssl文件夹为:nginx/cert
4、mysql默认容器启动执行的数据库脚本在 mysql/docker-entrypoint-initdb.d文件夹下，mongodb同理
5、workspace容器下crontab存放计划任务文件
6、php-fpm及workspace ext文件夹存放的是php扩展文件
