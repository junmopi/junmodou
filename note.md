**1.scp /usr/local/mongodb/mongodb.conf root@120.79.85.141:/home/download          scp命令——远端传输命令**

/usr/local/mongodb/mongodb.conf          ——表示需要传输的文件

root                                                                 ——用户

120.79.85.141                                               ——需要接收的ip地址

/home/download                                          ——存放传输文件的绝对路径

**2.mongodb目录下启动mongodb**

./bin/mongod --config /usr/local/mongodb/mongodb.conf

**3.在LINUX中，周期执行的任务一般由cron这个守护进程来处理\[ps -ef\|grep cron\]。cron读取一个或多个配置文件，这些配置文件中包含了命令行及其调用时间。**

crontab -l  查看是否启动定时任务

crontab -e 编辑执行定时任务

systemctl  enable  crond 自动启动定时任务

systemctl  start crond 开启定时任务服务

**4.phpstorm格式化：shift+alt+F**

**5.报seaslog错误时：**

查看seaslog目录的权限，若为root权限，则执行以下：

chown -R  www seaslog/

chgrp -R www seaslog/

**6.启动solor：**

/usr/local/solr/solr-5.5.0/bin/solr start -h localhost -p 8983 -m 1g

将

**7.启动etcd：**

* nohup etcd --listen-client-urls [http://10.27.166.170:2379](http://10.27.166.170:2379) --advertise-client-urls [http://10.27.166.170:2379](http://10.27.166.170:2379) &gt;/dev/null &   ** --启动etcd服务**

* nohup etcdctl watch sydev/modules/ sydev/modules0 &gt;/usr/local/inotify/symodules/change\_service.txt --endpoints=\[10.27.166.170:2379\] 2&gt;&1 &    **--启动etcd监听服务**

* chmod a+x /home/jw/phpspace/swooleyaf/symodules\_inotify.sh

* nohup sh /home/jw/phpspace/swooleyaf/symodules\_inotify.sh &gt;/dev/null 2&gt;&1 &** --启动inotify实时更新**

第一条和第二条的ip是后端服务器的内网ip，第二条的监听服务对应项目的环境，dev测试环境，product正式环境。

**8.启动MongoDB：**

/usr/local/mongodb/bin/mongod --dbpath=/usr/local/mongodb/data/db --logpath=/usr/local/mongodb/data/logs/mongodb.log  --fork

进入MongoDB：

/usr/local/mongodb/bin/mongo

**9-1.修改密码：**

/usr/local/php7/bin/php -r 'echo md5\("密码+密盐"\);'

git merge --no-ff  \[name\]

**9-2.同步数据库，生成表：**

/usr/local/php7-1/bin/php helper\_mysql.php entities -db xsh\_vote -path /xdata/phpspace/xshsyvote/syLibs/Entities/XshVote -suffix Entity

git status

git add syLibs/\*

git status

git commit -am "xxx"

git push origin dev

**10.生成API文档：**

cd apidoc/

apidoc -i /xdata/phpspace/xshsyvote -o /xdata/apidoc/xshsyvote

**11.异常处理流程：**

检查域名解析-&gt;ping出域名对应IP地址-&gt;检查环境访问的根目录-&gt;公众号对应的授权域名-&gt;商户平台对应的支付接口，以及支付证书-&gt;开放平台中绑定对应公众号-&gt;公众号中配置对应的IP白名单以获取access\_token

**12.启动redis：**

/etc/init.d/redis  start

rm -rf /var/run/redis\_6379.pid

/etc/init.d/redis  start

服务停了，需要重启基础服务，先查看服务，包括nginx、fpm、etcd、sh、api、redis等进程，没有的话需要启动这些服务，有etcd、redis、nginx、fpm，之后再启动项目服务，刷新缓存。

mysql启动在mysql那台服务器，systemctl start mysql

mongodb启动，在MongoDB那台服务器，/usr/local/mongodb/bin/mongod  --dbpath=/usr/local/mongodb/data/db --logpath=/usr/local/mongodb/data/logs/mongodb.log --fork

**13.镜像后设置数据库密码：**

cd /use/local/mysql

bin/mysql -u root

UPDATE user SET Password=PASSWORD\('XXXXX'\) where USER='root';－－修改密码

flush privileges;

exit;

systemctl  mysql  restart   －－重启mysql

mysql -u root -p GRANT ALL PRIVILEGES ON \*.\* TO'root'@'%'IDENTIFIED BY'密码'WITH GRANT OPTION; －－允许远程访问

flush privileges;

exit;

**14.安装加启动solr：**

将solr-5.5.0.tgz解压到/usr/local/solr/下

cd /usr/local/solr/solr-5.5.0

java -version  --看下java版本，是否为jdk1.8.0

bin/solr start -h localhost -m 1g -p 8983  --开启solr

bin/solr create -c solrFormal -p 8983  --创建

bin/solr stop -p 8983  --停止solr

cp /home/download/install/resources/java/ik-analyzer-solr5.jar /usr/local/solr/solr-5.5.0/server/solr-webapp/webapp/WEB-INF/lib/

将其他正式服务器上的managed-schema文件覆盖掉原来/usr/local/solr/solr-5.5.0/server/solr/solrFormal/conf/下的

再重启solr

**15.微信签名错误：**

确认了AppId，AppSecret, 商户平台中Key，商户平台中的客户密钥都没有问题，

用了微信接口工具测试了，确定MD5是完全正确的。

post的xml中确定加了CDATA

第一次设置的密钥，报签名错误

第二次又设置一个一模一样的密钥，终于成功了

**16.启动定时任务脚本命令：**

nohup sh /xdata/phpspace/xshsytask/startTaskCron.sh &gt;/dev/null 2&gt;&1 &    --常驻内存

将fpm加入到chkconfig来管理，通过service来启动：chkconfig --add /etc/init.d/php7-fpm

**17.linux命令大全：**[http://man.linuxde.net](http://man.linuxde.net)

**18.退出telnet：**

先Ctrl+\]，然后quit Connection closed退出。

swoole的onRequest事件中，服务启动后，服务器中监听的端口无没返回，需要在阿里云的安全组配置中开启相应的端口。

**19.新搭建的项目需知：**

项目中helper开头的某些文件中的ip地址，域名，目录，环境的更换；如定时任务中的ip地址和域名，sh脚本中的目录等。

**20.打印日志：**Log::log\("12345:" . print\_r\($statDayVotes, true\) . ' pids:' . print\_r\($pids, true\)\);

**21.启动swoole客户端：**正确的姿势，先启动之前做的TCP服务：php server.php 再启动这个客户端：php client.php

**22.php扩展下载地址：**[http://pecl.php.net](http://pecl.php.net)

**23.脚本安装：**

先检查好配置，ip是不是指向需要安装环境的ip。

/usr/local/python3/bin/fab -f fabfile.py installEnv:envType="syFrontBackend",envStep=1   ---安装前后端环境

/usr/local/python3/bin/fab -f fabfile.py installEnv:envType="syMysql",envStep=1   ---安装mysql

**24.redis异常解决：**

出现错误：Fatal error:  Uncaught RedisException: MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. Commands that may modify the data set are disabled. Please check Redis logs for details about the error

解决办法：

redis-cli    --连接到redis服务器

AUTH 'Redis数据库密码'

config set stop-writes-on-bgsave-error no  ---执行命令

**25.合并分支：**

git checkout master    ----切换到master分支

git merge --no-ff dev   -----将dev分支合并到master

git push origin master ----将合并分支后的代码上传

git checkout dev          ----切换回dev分支



