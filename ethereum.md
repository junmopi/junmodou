参考链接

以太坊中文: https://ethfans.org/wikis/Home

go客户端wiki: https://github.com/ethereum/go-ethereum/wiki

智能合约最优指导: https://github.com/ConsenSys/smart-contract-best-practices/blob/master/README-zh.md

安装

基础安装

前往https://github.com/ethereum/mist/releases下载Mist-win64-0-10-0.zip

解压Mist-win64-0-10-0.zip到E:\Ethereum

创建私有链

参考链接 https://blog.csdn.net/sportshark/article/details/51855007

打开Mist客户端,选择 开发-&gt;网络-&gt;Rinkeby

创建 ethblocks目录,并进入ethblocks目录

创建json文件

vim genesis.json

    {

        "config": {

            "chainId": 1,

            "homesteadBlock": 0,

            "eip155Block": 0,

            "eip158Block": 0

        },

        "nonce": 0x0000000000000042",

         "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",

        "difficulty": "0x4000",

        "alloc": {},

        "coinbase": "0x0000000000000000000000000000000000000000",

        "timestamp": "0x00",

        "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",

        "extraData": "0x00000000",

        "gasLimit": "0xffffffff"

    }

json参数解释

名称	描述

mixhash	与nonce配合用于挖矿,由上一个区块的一部分生成的hash.注意他和nonce的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, \(44\)章节所描述的条件

nonce	nonce就是一个64位随机数,用于挖矿,注意他和mixhash的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, \(44\)章节所描述的条件

difficulty	设置当前区块的难度,如果难度过大，cpu挖矿就很难

alloc	用来预置账号以及账号的以太币数量,因为私有链挖矿比较容易,所以我们不需要预置有币的账号,需要的时候自己创建即可以

coinbase	矿工的账号,随便填

timestamp	设置创世块的时间戳

parentHash	上一个区块的hash值,因为是创世块,所以这个值是0

extraData	附加信息,随便填,可以填你的个性信息

gasLimit	该值设置对GAS的消耗总量限制,用来限制区块能包含的交易信息总和,因为我们是私有链,所以填最大

初始化创世块

geth.exe --datadir "ethblocks\chain" init piccgenesis.json

启动区块链节点

geth.exe --identity "PICCetherum" --rpc --rpccorsdomain "\*" --datadir "ethblocks\chain" --port "30303" --rpcapi "db,eth,net,web3" --networkid 95518 console 2&gt;&gt;geth.log

geth参数介绍

名称	描述

identity	区块链的标示,随便填写,用于标示目前网络的名字

init	指定创世块文件的位置,并创建初始块

datadir	设置当前区块链网络数据存放的位置

port	网络监听端口

rpc	启动rpc通信,可以进行智能合约的部署和调试

rpcapi	设置允许连接的rpc的客户端,一般为db,eth,net,web3

networkid	设置当前区块链的网络ID,用于区分不同的网络,是一个数字

console	启动命令行模式,可以在Geth中执行命令

创建私有链账户

personal.newAccount\(\)

password

password

导入账户

  //密钥文件存储路径

  Windows: C:\Users\username\%appdata%\Roaming\Ethereum\keystore

  Linux: ~/.ethereum/keystore

  Mac: ~/Library/Ethereum/keystore

    

  geth --password 密码 account import /path/to/keyfile

添加节点

//查看自己节点信息

admin.nodeInfo

//获取enode的值并将0.0.0.0替换成自己的ip然后发送给其他节点

enode://f5496dcd52fb2f434a1d060c920a62c25d32af825aa18f67d347d6c6d362c4f8b5aeba79355fc2ed2e71f11a012cd46063a6e24e43cd00304834648e85136edb@0.0.0.0:30303 -&gt; enode://f5496dcd52fb2f434a1d060c920a62c25d32af825aa18f67d347d6c6d362c4f8b5aeba79355fc2ed2e71f11a012cd46063a6e24e43cd00304834648e85136edb@192.168.2.112:30303

查看账户余额

//参数为区块链地址

eth.getBalance\("0x7d1f7be4112ce63b9de04a0bf95c1e87e430bd1b"\)

转账 //user1向user2转账3个以太币 personal.unlockAccount\(user1, ‘密码’\) eth.sendTransaction\({from:user1,to:user2,value:web3.toWei\(3,”ether”\)}\)

配置

将C:\Users\jw\AppData\Roaming\Mist\binaries\Geth\unpacked添加到系统环境配置

