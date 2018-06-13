pragma solidity ^0.4.21;

contract ExtraBalToken {
    uint256 public totalSupply;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Send coins */
    function transfer(address _to, uint256 _value)public {
        if (balanceOf[msg.sender] < _value) revert();           // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) revert(); // Check for overflows
        balanceOf[msg.sender] -= _value;                     // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
        emit Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
    }

    /* Allow another contract to spend some tokens in your behalf */
    function approve(address _spender, uint256 _value)public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    /* A contract attempts to get the coins */
    function transferFrom(address _from, address _to, uint256 _value)public returns (bool success) {
        if (balanceOf[_from] < _value) revert();                 // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) revert();  // Check for overflows
        if (_value > allowance[_from][msg.sender]) revert();   // Check allowance
        balanceOf[_from] -= _value;                          // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    /* This unnamed function is called whenever someone tries to send ether to it */
    function ()public {
        revert();     // Prevents accidental sending of ether
    }

    uint constant D160 = 10000000000000000000000000000000000000000;

    address public owner;

    function ExtraBalToken()public {
        owner = msg.sender;
    }

    bool public sealed;
    // The 160 LSB is the address of the balance
    // The 96 MSB is the balance of that address.
    function fill(uint[] data)public {
        if ((msg.sender != owner)||(sealed))
            revert();

        for (uint i=0; i<data.length; i++) {
            address a = address( data[i] & (D160-1) );
            uint amount = data[i] / D160;
            if (balanceOf[a] == 0) {   // In case it's filled two times, it only increments once
                balanceOf[a] = amount;
                totalSupply += amount;
            }
        }
    }

    function seal()public {
        if ((msg.sender != owner)||(sealed))
            revert();

        sealed= true;
    }

}