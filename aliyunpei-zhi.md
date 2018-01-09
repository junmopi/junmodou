1.安装Apache

下载安装：yum install httpd httpd-devel   


启动：systemctl start httpd  


2.安装PHP——5.6版本

1\) 配置yum源

yum install epel-release  


rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm  


2\) 修改配置

httpd.conf 中加上 AddType application/x-httpd-php .php

在DirectoryIndex index.html中加入index.htm index.php

3\) 在/var/www/html目录中建test.php文件

&lt;?php phpinfo\(\); ?&gt;

3.使用云数据库RDS

![](https://attachments.tower.im/tower/a73d4712c2e84407a4f615b97399d433?version=auto&filename=image.png "image.png")  


点击 1 进入RDS，点击 2 选择自己建数据库所选区，点击 3 进入管理

![](https://attachments.tower.im/tower/0b6783d18bb344cda04ce33d10611e16?version=auto&filename=image.png "image.png")点击账号管理添加用户，然后就可以使用此账号登录数据库  


配置白名单，准确定位本地IP

先将白名单设置为0.0.0.0/0，使用MySQL客户端连接上云数据库，在输入 **show processlist; **查看

![](https://attachments.tower.im/tower/89552fcc858e4b3c8c1130487cbb1174?version=auto&filename=image.png "image.png")

