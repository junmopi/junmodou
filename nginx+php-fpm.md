# Nginx+PHP-FPM时快时慢的解决

|  |  |  |
| :--- | :--- | :--- |


**原因**：

一个测试环境，nginx+php-fpm对外提供服务，测试人员访问的时候出现时快时慢的情况，慢时超过了正常网页的等待打开时间范围。重启nginx php-fpm后恢复，访问几次后又会慢

**查找思路**：

1，系统负载，磁盘IO

  
top，查看负载，负载小于1 排除。

  
vmstat 查看磁盘io  测试环境 io较小，排除。

2，是否有php慢查询程序

打开php-fpm中php慢查询日志

request\_slowlog\_timeout = 5

slowlog = var/log/slow.log

reload 访问之后无慢查询日志，判断无执行时间比较慢的php程序

检查该配置文件

pm = static

pm.max\_children = 300

pm.start\_servers = 15

pm.min\_spare\_servers = 8

pm.max\_spare\_servers = 48

request\_terminate\_timeout = 200

排除是pm.max\_children  设置过小引起的问题。

3，怀疑mysql有慢查询

网站时快时慢 重启之后打开统一页面较快，排除mysql有慢查询。此时陷入迷茫尴尬之中。

**查看nginx配置文件**

worker\_rlimit\_nofile 65535 偶然发现多么熟悉的数字，此处定义了限制打开的文件数量，就联想到ulimit 参数

ulimit -n 果然  没有进行优化，显示默认的1024

echo '\*  -  nofile  65535' &gt;&gt; /etc/security/limits.conf

然后执行下ulimit -HSn 65535

也可以把ulimit -SHn 65535命令加入到/etc/rc.local，然后每次重启生效

**文件描述符**

文件描述符在形式上是一个非负整数。实际上，它是一个索引值，指向内核为每一个进程所维护的该进程打开文件的记录表。当程序打开一个现有文件或者创建一个新文件时，内核向进程返回一个文件描述符。在程序设计中，一些涉及底层的程序编写往往会围绕着文件描述符展开。但是文件描述符这一概念往往只适用于Unix、Linux这样的操作系统。

习惯上，标准输入（standard input）的文件描述符是 0，标准输出（standard output）是 1，标准错误（standard error）是 2。尽管这种习惯并非Unix内核的特性，但是因为一些 shell 和很多应用程序都使用这种习惯，因此，如果内核不遵循这种习惯的话，很多应用程序将不能使用。

调整完之后访问时快时慢的问题解决。

