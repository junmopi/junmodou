需将整个web系统的目录设置 755 ，而不是设置runtime。

如/data/wwwroot 是站点的根目录

ps -ef\|grep nginx 查看nginx的权限组，若为www权限，则执行如下： 否则，只需将www替换成对应的权限组即可；

```
chown -R www:www /data/wwwroot/
```

```
chmod -R 755 /data/wwwroot/
```



