1.scp /usr/local/mongodb/mongodb.conf root@120.79.85.141:/home/download

scp命令——远端传输命令

/usr/local/mongodb/mongodb.conf          ——表示需要传输的文件

root                                                                 ——用户

120.79.85.141                                               ——需要接收的ip地址

/home/download                                          ——存放传输文件的绝对路径

2.mongodb目录下启动mongodb

./bin/mongod --config /usr/local/mongodb/mongodb.conf

3.在LINUX中，周期执行的任务一般由cron这个守护进程来处理\[ps -ef\|grep cron\]。cron读取一个或多个配置文件，这些配置文件中包含了命令行及其调用时间。

crontab -l  查看是否启动定时任务

crontab -e 编辑执行定时任务

systemctl  enable  crond 自动启动定时任务

systemctl  start crond 开启定时任务服务

报seaslog错误时：

chown -R  www seaslog/

chgrp -R www seaslog/

启动solor：

/usr/local/solr/solr-5.5.0/bin/solr start -h localhost -p 8983 -m 1g

启动etcd：

nohup etcd --listen-client-urls [http://10.27.166.170:2379](http://10.27.166.170:2379) --advertise-client-urls [http://10.27.166.170:2379](http://10.27.166.170:2379) &gt;/dev/null &    --启动etcd服务

* nohup etcdctl watch sydev/modules/ sydev/modules0 &gt;/usr/local/inotify/symodules/change\_service.txt --endpoints=\[10.27.166.170:2379\] 2&gt;&1 &    --启动etcd监听服务

* chmod a+x /home/jw/phpspace/swooleyaf/symodules\_inotify.sh

* nohup sh /home/jw/phpspace/swooleyaf/symodules\_inotify.sh &gt;/dev/null 2&gt;&1 & --启动inotify实时更新

启动MongoDB：

/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/mongodb.conf 

进入MongoDB：

/usr/local/mongodb/bin/mongo



