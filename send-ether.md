我们将创建一个数字令牌。Ethereum生态系统中的令牌可以表示任何可替代的交易好:代币,忠诚点,黄金证书,借据,游戏项目,等。因为所有的令牌实现一些基本功能在一种标准的方式,这也意味着你的令牌将会立即兼容Ethereum钱包和其他客户或合同,使用相同的标准。

最小可行的令牌

标准的令牌合同可能相当复杂。但本质上，一个非常基本的标记可以归结为:

pragma solidity ^0.4.20;

contract MyToken {

```
/\* This creates an array with all balances \*/

mapping \(address =&gt; uint256\) public balanceOf;



/\* Initializes contract with initial supply tokens to the creator of the contract \*/

function MyToken\(

    uint256 initialSupply

    \) public {

    balanceOf\[msg.sender\] = initialSupply;              // Give the creator all initial tokens

}



/\* Send coins \*/

function transfer\(address \_to, uint256 \_value\) public {

    require\(balanceOf\[msg.sender\] &gt;= \_value\);           // Check if the sender has enough

    require\(balanceOf\[\_to\] + \_value &gt;= balanceOf\[\_to\]\); // Check for overflows

    balanceOf\[msg.sender\] -= \_value;                    // Subtract from the sender

    balanceOf\[\_to\] += \_value;                           // Add the same to the recipient

}
```

}

代码

但是如果你只是想复制粘贴一个更完整的代码，然后使用这个:

pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval\(address \_from, uint256 \_value, address \_token, bytes \_extraData\) external; }

contract TokenERC20 {

    // Public variables of the token

    string public name;

    string public symbol;

    uint8 public decimals = 18;

    // 18 decimals is the strongly suggested default, avoid changing it

    uint256 public totalSupply;



    // This creates an array with all balances

    mapping \(address =&gt; uint256\) public balanceOf;

    mapping \(address =&gt; mapping \(address =&gt; uint256\)\) public allowance;



    // This generates a public event on the blockchain that will notify clients

    event Transfer\(address indexed from, address indexed to, uint256 value\);



    // This notifies clients about the amount burnt

    event Burn\(address indexed from, uint256 value\);



    /\*\*

     \* Constructor function

     \*

     \* Initializes contract with initial supply tokens to the creator of the contract

     \*/

    function TokenERC20\(

        uint256 initialSupply,

        string tokenName,

        string tokenSymbol

    \) public {

        totalSupply = initialSupply \* 10 \*\* uint256\(decimals\);  // Update total supply with the decimal amount

        balanceOf\[msg.sender\] = totalSupply;                // Give the creator all initial tokens

        name = tokenName;                                   // Set the name for display purposes

        symbol = tokenSymbol;                               // Set the symbol for display purposes

    }



    /\*\*

     \* Internal transfer, only can be called by this contract

     \*/

    function \_transfer\(address \_from, address \_to, uint \_value\) internal {

        // Prevent transfer to 0x0 address. Use burn\(\) instead

        require\(\_to != 0x0\);

        // Check if the sender has enough

        require\(balanceOf\[\_from\] &gt;= \_value\);

        // Check for overflows

        require\(balanceOf\[\_to\] + \_value &gt;= balanceOf\[\_to\]\);

        // Save this for an assertion in the future

        uint previousBalances = balanceOf\[\_from\] + balanceOf\[\_to\];

        // Subtract from the sender

        balanceOf\[\_from\] -= \_value;

        // Add the same to the recipient

        balanceOf\[\_to\] += \_value;

        emit Transfer\(\_from, \_to, \_value\);

        // Asserts are used to use static analysis to find bugs in your code. They should never fail

        assert\(balanceOf\[\_from\] + balanceOf\[\_to\] == previousBalances\);

    }



    /\*\*

     \* Transfer tokens

     \*

     \* Send \`\_value\` tokens to \`\_to\` from your account

     \*

     \* @param \_to The address of the recipient

     \* @param \_value the amount to send

     \*/

    function transfer\(address \_to, uint256 \_value\) public {

        \_transfer\(msg.sender, \_to, \_value\);

    }



    /\*\*

     \* Transfer tokens from other address

     \*

     \* Send \`\_value\` tokens to \`\_to\` on behalf of \`\_from\`

     \*

     \* @param \_from The address of the sender

     \* @param \_to The address of the recipient

     \* @param \_value the amount to send

     \*/

    function transferFrom\(address \_from, address \_to, uint256 \_value\) public returns \(bool success\) {

        require\(\_value &lt;= allowance\[\_from\]\[msg.sender\]\);     // Check allowance

        allowance\[\_from\]\[msg.sender\] -= \_value;

        \_transfer\(\_from, \_to, \_value\);

        return true;

    }



    /\*\*

     \* Set allowance for other address

     \*

     \* Allows \`\_spender\` to spend no more than \`\_value\` tokens on your behalf

     \*

     \* @param \_spender The address authorized to spend

     \* @param \_value the max amount they can spend

     \*/

    function approve\(address \_spender, uint256 \_value\) public

        returns \(bool success\) {

        allowance\[msg.sender\]\[\_spender\] = \_value;

        return true;

    }



    /\*\*

     \* Set allowance for other address and notify

     \*

     \* Allows \`\_spender\` to spend no more than \`\_value\` tokens on your behalf, and then ping the contract about it

     \*

     \* @param \_spender The address authorized to spend

     \* @param \_value the max amount they can spend

     \* @param \_extraData some extra information to send to the approved contract

     \*/

    function approveAndCall\(address \_spender, uint256 \_value, bytes \_extraData\)

        public

        returns \(bool success\) {

        tokenRecipient spender = tokenRecipient\(\_spender\);

        if \(approve\(\_spender, \_value\)\) {

            spender.receiveApproval\(msg.sender, \_value, this, \_extraData\);

            return true;

        }

    }



    /\*\*

     \* Destroy tokens

     \*

     \* Remove \`\_value\` tokens from the system irreversibly

     \*

     \* @param \_value the amount of money to burn

     \*/

    function burn\(uint256 \_value\) public returns \(bool success\) {

        require\(balanceOf\[msg.sender\] &gt;= \_value\);   // Check if the sender has enough

        balanceOf\[msg.sender\] -= \_value;            // Subtract from the sender

        totalSupply -= \_value;                      // Updates totalSupply

        emit Burn\(msg.sender, \_value\);

        return true;

    }



    /\*\*

     \* Destroy tokens from other account

     \*

     \* Remove \`\_value\` tokens from the system irreversibly on behalf of \`\_from\`.

     \*

     \* @param \_from the address of the sender

     \* @param \_value the amount of money to burn

     \*/

    function burnFrom\(address \_from, uint256 \_value\) public returns \(bool success\) {

        require\(balanceOf\[\_from\] &gt;= \_value\);                // Check if the targeted balance is enough

        require\(\_value &lt;= allowance\[\_from\]\[msg.sender\]\);    // Check allowance

        balanceOf\[\_from\] -= \_value;                         // Subtract from the targeted balance

        allowance\[\_from\]\[msg.sender\] -= \_value;             // Subtract from the sender's allowance

        totalSupply -= \_value;                              // Update totalSupply

        emit Burn\(\_from, \_value\);

        return true;

    }

}

让我们从基础开始。打开钱包应用程序，转到合同选项卡，然后部署新的合同。在Solidity Contract源代码文本字段中，键入下面的代码:

contract MyToken {

```
    /\* This creates an array with all balances \*/

    mapping \(address =&gt; uint256\) public balanceOf;

}
```

映射表示关联数组，在其中将地址与余额联系起来。地址是基本的十六进制以太格式，而余额是整数，从0到115 quattuorvigintillion。如果你不知道一个quattuorvigintillion是多少，它是许多vigintillions比任何你计划使用你的代币的东西。public关键字，意味着这个变量将被区块链上的任何人访问，这意味着所有的余额都是公共的\(他们需要这样做，以便客户显示它们\)。

如果你马上公布了你的合同，它就会起作用，但并不是很有用:它将是一份合同，可以查询你的硬币的任何地址的余额——但是，因为你从来没有创造过一枚硬币，所以每一个硬币都会返回0。我们将在启动时创建一些令牌。将此代码添加到最后一个关闭括号之前，就在映射下面...行。

function MyToken\(\) {

```
    balanceOf\[msg.sender\] = 21000000;

}
```

请注意，函数MyToken与契约MyToken具有相同的名称。这是非常重要的，如果您重命名一个，您也必须重命名另一个:这是一个特殊的启动函数，它只运行一次，并且只有当契约第一次上传到网络时才运行。这个函数将设置msg的平衡。发件人，使用合同的用户，余额为2100万。

选择2100万是相当随意的，您可以将其更改为代码中需要的任何内容，但是有一个更好的方法:相反，将它作为函数的一个参数提供，如下所示:

function MyToken\(uint256 initialSupply\) public {

```
    balanceOf\[msg.sender\] = initialSupply;

}
```

看一下合同旁边的右边栏，你会看到一个下拉列表，写着签合同。选择“MyToken”契约，您将看到现在它显示了一个名为构造函数参数的部分。这些是您的令牌的可变参数，因此您可以重用相同的代码，并且只在将来更改这些变量。

现在你有了一个功能契约，它创建了令牌的余额，但是由于没有任何函数来移动它，它所做的只是停留在相同的帐户上。现在我们要实现它。在最后一个括号之前写下面的代码。

/\* Send coins \*/

```
function transfer\(address \_to, uint256 \_value\) {

    /\* Add and subtract new balances \*/

    balanceOf\[msg.sender\] -= \_value;

    balanceOf\[\_to\] += \_value;

}
```

这是一个非常简单的函数:它有一个接收方和一个值作为参数，当有人调用它时，它将从它们的余额中减去\_value并将其添加到\_to balance。现在有一个明显的问题:如果这个人想要发送比它拥有的更多的东西会发生什么?由于我们不想在这个特殊的合同中处理债务，我们只是简单地做一个快速检查，如果发件人没有足够的资金，合同的执行就会停止。它还可以检查溢出，避免有一个如此大的数字，使它再次变为零。

为了阻止合同的执行，你可以返回或者扔掉前者，后者的成本会更低，但是，随着你对合同做的任何改变都将被保留下来，它会让你更加头疼。另一方面，“throw”将取消所有的合同执行，恢复交易可能产生的任何变更，发送者将失去他所发送的所有乙醚。但是由于钱包可以检测到合同将会扔，它总是显示一个警报，因此防止任何以太的花费。

function transfer\(address \_to, uint256 \_value\) {

```
    /\* Check if sender has balance and for overflows \*/

    require\(balanceOf\[msg.sender\] &gt;= \_value && balanceOf\[\_to\] + \_value &gt;= balanceOf\[\_to\]\);



    /\* Add and subtract new balances \*/

    balanceOf\[msg.sender\] -= \_value;

    balanceOf\[\_to\] += \_value;

}
```

现在缺少的是关于合同的一些基本信息。在不久的将来，这可以由一个令牌注册表来处理，但是现在我们将直接将它们添加到合同中:

string public name;

string public symbol;

uint8 public decimals;

现在我们更新构造函数，允许在开始时设置所有这些变量:

/\* Initializes contract with initial supply tokens to the creator of the contract \*/

```
function MyToken\(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits\) {

    balanceOf\[msg.sender\] = initialSupply;              // Give the creator all initial tokens

    name = tokenName;                                   // Set the name for display purposes

    symbol = tokenSymbol;                               // Set the symbol for display purposes

    decimals = decimalUnits;                            // Amount of decimals for display purposes

}
```

最后，我们现在需要一些所谓的事件。这些是特殊的、空的函数，您可以调用这些函数来帮助像Ethereum钱包这样的客户跟踪契约中发生的活动。事件应该以大写字母开头。在合同开始时加上这条线来宣布事件:

event Transfer\(address indexed from, address indexed to, uint256 value\);

然后你只需要把这两条添加到“传递”函数中:

/\* Notify anyone listening that this transfer took place \*/

```
Transfer\(msg.sender, \_to, \_value\);
```

现在你的令牌已经准备好了!

注意到评论?

您可能会问，那些@notice和@param注释是什么?这是自然语言规范的一个新兴标准，它允许钱包向用户展示合同即将要做的自然语言描述。虽然目前没有很多钱包支持，但这将在未来发生改变，所以做好准备是件好事。

如何部署

如果你不在那里，打开Ethereum钱包，到合同标签，然后点击“部署新合同”。

现在从上面获取令牌源并将其粘贴到“Solidity source域”中。如果代码没有任何错误编译，您应该看到右侧的“选择一个契约”下拉列表。获取并选择“MyToken”契约。在右边的列中，您将看到个性化您自己的令牌所需的所有参数。您可以随意调整它们，但是为了本教程的目的，我们建议您选择这些参数:10,000作为供应，任何您想要的名称，“%”作为一个符号和两个小数位。你的应用程序应该是这样的:

Ethereum钱包截图2015-12-03 3.50.36 PM 10。

滚动到页面的末尾，你会看到这个合同的计算成本的估计，你可以选择你愿意支付多少以太的费用。你不花的任何多余的醚都会被退还给你，这样你就可以离开默认设置。按“部署”，输入您的帐户密码，等待几秒钟的时间，您的事务将被接收。

Ethereum钱包截图2015-12-03 3.50.36 PM 11。

您将被重定向到首页，在那里您可以看到您的事务等待确认。点击“Etherbase”\(你的主要账户\)账户，在不超过一分钟后，你会发现你的账户将显示你拥有你刚刚创建的100%的股份。发送一些给一些朋友:选择“发送”，然后选择你想发送的货币\(或你新创建的股票\)，粘贴你朋友的地址在“To”字段和按“发送”。

以太币交易官方网站:https://etherscan.io/

查看以太币余额:https://www.etherchain.org/

