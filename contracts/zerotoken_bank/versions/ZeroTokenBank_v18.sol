/// @custom:version all methods do nothing.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract ZeroTokenBank {
    uint contract_balance;
    mapping (address => uint) balances;

    function balanceOf(address addr) public view returns (uint) {
    }

    function totalBalance() public view returns (uint) {
    }

    function deposit(uint amount) public {
    }

    function withdraw(uint amount) public {
    }
}
