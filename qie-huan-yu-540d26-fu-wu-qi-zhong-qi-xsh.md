\#\# 域名不变,切换服务器

1. 登录阿里云控制台-&gt;域名与网站-&gt;云解析

2. 搜索域名-&gt;修改记录值,换成需要更改的IP地址



\#\# 域名切换

\#\#\# 后端操作\(投票\)

1. xshell登录后端服务器\(名称:投票api\)

2. cd /home/configs/yaconf && vim project.ini 修改domain.cookie.base && domain.front.vote的域名,当对应公众号的两个域名\(除中转域名外\)都无法使用时,domaincookie两个都需要更改。

3. cd /home/phpspace/xshsy && /usr/local/php7/bin/php helper\_service\_manager.php -s stop-all && 间隔3秒 && /usr/local/php7/bin/php helper\_service\_manager.php -s start-all && 间隔3秒 && /usr/local/php7/bin/php helper\_votetask.php -refreshwx 1

\#\#\# 前端操作\(投票\)

1. xshell登录前端服务器\(名称:微品redis\_投票前端\)

2. cd /www/yaconf 

3. vim xshApiConfig.ini 修改vote相关的域名配置，当对应公众号的两个域名\(除中转域名外\)都无法使用时,domaincookie两个都需要更改。 vim xshvote.ini 修改不同公众号下所对应需要更换的域名，并将旧域名添加到下面

4. systemctl stop php7-fpm && systemctl start php7-fpm

5. 当需要在公众平台修改域名时， cd /www/conf/nginx\(微品redis\_投票前端\)

6. 修改和投票相关的配置文件中server\_name值

7. systemctl stop nginx && systemctl start nginx

\#\#\# nginx中转服务器

1. cd /home/configs/nginx/servers/

2. 修改相应的配置文件中的server\_name值

3. 重启nginx服务:systemctl stop nginx && systemctl start nginx

\#\#\# 阿里云操作

1. 登录阿里云控制台

2. 域名与网站-&gt;云解析DNS 搜索新域名,设置域名解析服务器IP

3. 云计算基础服务-&gt;CDN-&gt;域名管理-&gt;配置-&gt;修改回源host

\#\#\# 公众号设置

1. 登录微信公众平台

2.在公众号设置-功能设置中，修改微信js域名,业务域名\(一个月最多修改3次\),授权回调域名为新域名地址\(每次更换都需要改\)

\#\#\# 商户平台设置

1. 登录微信商户平台

2. 产品中心-&gt;公众号支付-&gt;JSAPI支付授权目录,修改js支付域名地址



\#\# 后端服务重启

\#\#\# 微品

1. 登录服务器\(名称:微品后端api\_114\_微品前端\)

2. cd /www/xsh 

3. php7 controll.php -s stop-all\(执行2-3次\)

4. 上述php命令如果执行第二次,第三次依然出现success,则执行 ps -ef\|grep o2o 获取进程ID,然后执行 kill -15 进程ID 强制杀死进程

5. php7 controll.php -s start-all

6. 登录服务器\(名称:微品后端\_O2O后端\)

7. cd /xdata/xsh && 再次执行步骤3-5

\#\#\# 投票

1. 登录服务器\(名称:投票api\)

2. cd /home/phpspace/xshsy 

3. /usr/local/php7/bin/php helper\_service\_manager.php -s stop-all\(执行2-3次\)

4. 上述php命令如果执行第二次,第三次依然出现success,则执行 ps -ef\|grep vote 获取进程ID,然后执行 kill -15 进程ID 强制杀死进程

5. 上述php命令如果执行第二次都是fail,间隔3秒 && /usr/local/php7/bin/php helper\_service\_manager.php -s start-all

6. 间隔3秒 && /usr/local/php7/bin/php helper\_votetask.php -refreshwx 1



\#\# 其他

\#\#\# 查看磁盘使用率 df -h

\#\#\# 查看内存和系统状况 htop,如果没有该命令,执行yum install htop

\#\#\# 查看端口占用情况 netstat -nalp \|grep 端口

\#\#\# 查看php进程数 ps -ef\|grep php \|wc -l

\#\#\# 查看某一目录下的内存使用情况 du -sh \*\|sort -n



\#\#\#投票php-fpm配置路径：/usr/local/php7/etc/php-fpm.d/www.conf

\#\#\#投票，查看nginx配置是否正确：/usr/local/nginx/sbin/nginx  -t



