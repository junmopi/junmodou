配置https：

1.在腾讯云申请ssl免费安全证书，通用名称填写对应的访问域名，申请邮箱填写账号邮箱地址，备注名自定义，密码可以不填写，然后下一步，选手动DNS验证，然后确认申请。

2.确认申请证书的域名、主机记录、记录值等，然后在阿里云（万网）中对应的域名进行DNS解析，找到证书对应的域名，添加解析，记录类型选择TXT，再把申请证书时获取到的主机记录和记录值填写进去，然后确认。

3.经过DNS解析后，还需要腾讯的CA扫描\(大概5-10分钟\)验证通过才会颁发证书，然后是下载证书，下载的证书中支持Apache、IIS、Nginx、Tomcat，只需要将对应的服务器配置文件放到访问的根目录下即可，例如Nginx，就只需要将下载好的证书中的Nginx文件夹中的两个文件放到服务器上，然后再在对应访问的.conf中配置https，配置里面将上传的两个文件引入，具体配置不赘述，另外，服务器中需要打开443端口。

4.如果需要通过阿里云的CDN访问https，则需要添加该域名的CDN加速域名，源站类型选择源站域名，将访问域名加进去，端口选择443端口。之后需要审核\(10-15分钟\)，同时需要为CDN加速域名申请一个https安全证书，操作同上，再就是配置，开启回源host填写访问的域名，https配置项中，开启https，选择证书-&gt;自定义上传，证书名称自定义，再把公钥\(需要pem格式的,而下载的免费证书为crt格式,需要进行如下的格式转换\)和私钥填到对应的栏目，确定就可以了。

5.证书格式转换，crt转pem：

在服务器中，首先将crt转换成der格式   openssl x509 -in input.crt -out input.der -outform DER

然后再将der转换为pem格式  openssl x509 -in input.der -inform DER -out output.pem -outform PEM

最后将key转换为pem格式 openssl rsa -in demo.key -out demo.pem

6.将配置好的CDN加速域名中的CName值复制，解析到对应域名上，主机记录为CDN加速域名，将记录值粘贴，确认。

7.在服务器domain.ini配置中加入CDN加速域名，与前端相对应，重启fpm。



**配置示例：**

server {

    listen 443 ssl http2;

    server\_name vote.xshapp.cn;

    root /xdata/www/xshwp/vote\_wx/www;

    index index.php;

    add\_header Cache-Control 'no-store';

    ssl on;

    ssl\_certificate /home/configs/nginx/certs/1\_vote.xshapp.cn\_bundle.crt;

    ssl\_certificate\_key /home/configs/nginx/certs/2\_vote.xshapp.cn.key;

    ssl\_session\_cache shared:SSL:5m;

    ssl\_session\_timeout 30m;

    ssl\_protocols TLSv1 TLSv1.1 TLSv1.2;

    ssl\_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305 ECDHE-RSA-CHACHA20-POLY1305 ECDHE-ECDSA-AES128-GCM-SHA256 ECDHE-RSA-AES128-GCM-SHA256 ECDHE-ECDSA-AES256-GCM-SHA384 ECDHE-RSA-AES256-GCM-SHA384 DHE-RSA-AES128-GCM-SHA256 DHE-RSA-AES256-GCM-SHA384 ECDHE-ECDSA-AES128-SHA256 ECDHE-RSA-AES128-SHA256 ECDHE-ECDSA-AES128-SHA ECDHE-RSA-AES256-SHA384 ECDHE-RSA-AES128-SHA ECDHE-ECDSA-AES256-SHA384 ECDHE-ECDSA-AES256-SHA ECDHE-RSA-AES256-SHA DHE-RSA-AES128-SHA256 DHE-RSA-AES128-SHA DHE-RSA-AES256-SHA256 DHE-RSA-AES256-SHA ECDHE-ECDSA-DES-CBC3-SHA ECDHE-RSA-DES-CBC3-SHA EDH-RSA-DES-CBC3-SHA AES128-GCM-SHA256 AES256-GCM-SHA384 AES128-SHA256 AES256-SHA256 AES128-SHA AES256-SHA DES-CBC3-SHA !DSS';

    ssl\_prefer\_server\_ciphers on;

    add\_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload" always;

    location / {

        try\_files $uri $uri/ /index.php?$query\_string;

    }

    location ~ \.php$ {

        fastcgi\_pass 127.0.0.1:9001;

        fastcgi\_index index.php;

        include fastcgi.conf;

    }

    location ~ .\*\.\(html\|htm\|gif\|jpg\|jpeg\|bmp\|png\|ico\|txt\|js\|css\)$ {

        expires 10m;

    }

}

