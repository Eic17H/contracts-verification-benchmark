/// @custom:version all methods always revert.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract ZeroTokenBank {
    uint contract_balance;
    mapping (address => uint) balances;

    function balanceOf(address addr) public view returns (uint) {
        require(false);
        return balances[addr];
    }

    function totalBalance() public view returns (uint) {
        require(false);
        return contract_balance;
    }

    function deposit(uint amount) public {
        require(false);
        balances[msg.sender] += amount;
        contract_balance += amount;
    }

    function withdraw(uint amount) public {
        require(false);
        require(amount > 0);
        require(amount <= balances[msg.sender]);

        balances[msg.sender] -= amount;

        contract_balance -= amount;
    }
}
