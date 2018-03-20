需将整个web系统的目录设置 755 ，而不是设置runtime。

如/data/wwwroot 是站点的根目录

```
chown -R www:www /data/wwwroot/
```

```
chmod -R 755 /data/wwwroot/
```





