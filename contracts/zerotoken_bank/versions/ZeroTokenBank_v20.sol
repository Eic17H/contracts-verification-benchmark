/// @custom:version all methods do nothing, but revert when they should.
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
        require(balances[msg.sender] <= MAX_UINT - amount);
    }

    function withdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balances[msg.sender]);
    }
}
