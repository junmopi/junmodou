合约部署流程

一般来说，部署智能合约的步骤为  
1启动一个以太坊节点 \(例如geth或者testrpc\)。  
2用solc编译智能合约。 =&gt; 获得二进制代码。  
3编译好的合约部署到网络。（这一步会消耗以太币，还需要使用你的节点的默认地址或者指定地址来给合约签名。） =&gt; 获得合约的区块链地址和ABI（合约接口的JSON表示，包括变量，事件和可以调用的方法）。\(译注：作者在这里把ABI与合约接口弄混了。ABI是合约接口的二进制表示。\)  
4 eb3.js提供的JavaScript API来调用合约。（根据调用的类型有可能会消耗以太币。）

eth.accounts 查看已拥有的以太坊账户

personal.newAccount\("password"\)  创建一个新用户

miner.start\(\)  开始挖矿

miner.stop\(\)  结束挖矿

eth.getBalance\(eth.accounts\[0\]\) 或者 web3.fromWei\(eth.getBalance\(eth.accounts\[0\]\), "ether"\)      查询第一个账户的余额

admin.nodeInfo   查看节点信息

eth.coinbase   查看当前矿工账户

personal.unlockAccount\(eth.accounts\[0\]\)      **解锁账号：** 使用账户资金前都需要先解锁账号

转账：eth.sendTransaction\({from:eth.accounts\[0\],to:"0xdc863b5fa618e1327054be5dbfec7f6809cad136",value:web3.toWei\(3,"ether"\)}\)

使用 txpool.status 可以看到交易状态

**查看区块数据**

 eth.blockNumber

 eth.getTransaction\("0x0c59f431068937cbe9e230483bc79f59bd7146edc8ff5ec37fea6710adcab825"\)

 eth.getBlock\(1\) 通过区块号查看区块

