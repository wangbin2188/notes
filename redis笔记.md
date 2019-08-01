Redis

安装

`Brew install redis`

配置文件 （改 daemonize no 为 daemonize **yes** ，这样就可以默认启动就后台运行）

`/usr/local/etc/redis.conf `

启动redis

`redis-server /usr/local/etc/redis.conf`

启动redis控制台

Redis-cli

是的

是的

登陆跳板机访问redis

`redis-cli -h search-engine.mxcyd8.ng.0001.usw2.cache.amazonaws.com -p6379`



lrange pid:708203:summary:ImpressionCount 0 -1

lrange pid_3007237:summary|ImpressionCount 0 -1

lrange pid_2560793:summary|ImpressionCount 0 -1

 lrange pid_1547643:summary|ImpressionCount 0 -1