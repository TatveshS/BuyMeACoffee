// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

//Deployed to goerli at 0x9a34E4aA106c85e099188E161f2E13520E9defDb

contract BuyMeACoffee {
    //Event to emit when a Memo is created
    event NewMemo(address indexed from, uint timestamp, string name, string message);

    struct Memo{
        address from;
        uint timestamp;
        string name;
        string message;
    }
    Memo[] memos;

    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) payable public {
        require(msg.value > 0, "Can't Buy Coffee with 0Eth");
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory){
        return memos;
    }

}
