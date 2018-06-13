**二、函数的可见性**

Solidity为函数提供了四种可见性，external，public，internal，private。

**external**

声明为external的可以从其它合约或通过Transaction进行调用，所以声明为external的函数是合约对外接口的一部分。

不能以internal的方式进行调用。

有时在接收大的数据数组时性能更好。

pragma solidity ^0.4.5;

contract FuntionTest{

    function externalFunc\(\) external{}



    function callFunc\(\){

        //以\`internal\`的方式调用函数报错

        //Error: Undeclared identifier.

        //externalFunc\(\);

        

        //以\`external\`的方式调用函数

        this.externalFunc\(\);

    }

}

声明为external的externalFunc\(\)只能以external的方式进行调用，以internal的方式调用会报Error: Undeclared identifier.。



**public**

函数默认声明为public。

public的函数既允许以internal的方式调用，也允许以external的方式调用。

public的函数由于被外部合约访问，是合约对外接口的一部分。

pragma solidity ^0.4.5;



contract FuntionTest{

    //默认是public函数

    function publicFunc\(\){}



    function callFunc\(\){

        //以\`internal\`的方式调用函数

        publicFunc\(\);

        

        //以\`external\`的方式调用函数

        this.publicFunc\(\);

    }

}

我们可以看到声明为public的publicFunc\(\)允许两种调用方式。



**internal**

在当前的合约或继承的合约中，只允许以internal的方式调用。

pragma solidity ^0.4.5;



contract A{

    //默认是public函数

    function internalFunc\(\) internal{}



    function callFunc\(\){

        //以\`internal\`的方式调用函数

        internalFunc\(\);

    }

}

contract B is A{

    //子合约中调用

    function callFunc\(\){

        internalFunc\(\);

    }

}

上述例子中声明为internal的internalFunc\(\)在定义合约，和子合约中均只能以internal的方式可以进行调用。



**private**

只能在当前合约中被访问（不可在被继承的合约中访问）。

即使声明为private，仍能被所有人查看到里面的数据。访问权限只是阻止了其它合约访问函数或修改数据。

pragma solidity ^0.4.5;



contract A{

    //默认是public函数

    function privateFunc\(\) private{}



    function callFunc\(\){

        //以\`internal\`的方式调用函数

        privateFunc\(\);

    }

}

contract B is A{

    //不可调用\`private\`

    function callFunc\(\){

        //privateFunc\(\);

    }

}

