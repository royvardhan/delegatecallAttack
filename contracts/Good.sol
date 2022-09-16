// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Good {
    address public helper; // slot 0
    address public owner; // slot 1
    uint public num; // slot 2

    constructor (address _helper) {
        helper = _helper;
        owner = msg.sender;
    }

    function setNum(uint _num) public {
        helper.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
    }
}

// We are calling the function on the Helper.sol contract but changing the state variables on the Good contract