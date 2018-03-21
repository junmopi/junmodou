需将整个web系统的目录设置 755 ，而不是设置runtime。

如/data/wwwroot 是站点的根目录

ps -ef\|grep nginx 查看nginx的权限组，若为www权限，则执行如下： 否则，只需将www替换成对应的权限组即可；

```
chown -R www:www /data/wwwroot/
```

```
chmod -R 755 /data/wwwroot/
```

当tp5打开遇到所有请求都只能访问首页的情况时，定是框架的路由规则问题、跨域问题或者二者的结合，

首先，检查Nginx或者Apache配置，一般的集成安装都会有防跨域的配置，首先将站点根目录下的.user.ini文件删除或者修改（加\#号注释掉）。

其次，进入配置文件，如nginx的配置文件放在/usr/local/nginx/conf/下的nginx.conf，将include enable-php.conf;替换成include enable-php-pathinfo.conf;然后vim pathinfo.conf，将try\_files $url =404;给注释掉。因tp5是同时支持pathinfo和rewrite，这样就解决了跨域的问题了。

最后，在tp框架中负责路由重写规则的文件.htaccess文件仅支持Apache，若是nginx，所以需要将该文件转换成Nginx的格式，网上有在线转换工具，转换好后，将该文件的绝对路径导入到nginx.conf中，如

location / {

```
        include  /站点根目录/项目根目录/该文件所在目录/.htaccess;

    }
```



