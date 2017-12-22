1.scp /usr/local/mongodb/mongodb.conf root@120.79.85.141:/home/download

scp命令——远端传输命令

/usr/local/mongodb/mongodb.conf          ——表示需要传输的文件

root                                                                 ——用户

120.79.85.141                                               ——需要接收的ip地址

/home/download                                          ——存放传输文件的绝对路径



2.mongodb目录下启动mongodb

./bin/mongod --config /usr/local/mongodb/mongodb.conf

