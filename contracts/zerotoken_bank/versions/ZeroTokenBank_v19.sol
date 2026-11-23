/// @custom:version all methods always revert and have no code.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract ZeroTokenBank {
    uint contract_balance;
    mapping (address => uint) balances;

    function balanceOf(address addr) public view returns (uint) {
        require(false);
    }

    function totalBalance() public view returns (uint) {
        require(false);
    }

    function deposit(uint amount) public {
        require(false);
    }

    function withdraw(uint amount) public {
        require(false);
    }
}
