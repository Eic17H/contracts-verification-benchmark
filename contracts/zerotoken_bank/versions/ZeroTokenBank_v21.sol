/// @custom:version compliant with the specification.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

import "./lib/ReentrancyGuard.sol";

contract ZeroTokenBank is ReentrancyGuard {
    uint contract_balance;
    mapping (address => uint) balances;

    function balanceOf(address addr) public nonReentrant returns (uint) {
        return balances[addr];
    }

    function totalBalance() public nonReentrant returns (uint) {
        return contract_balance;
    }

    function deposit(uint amount) public nonReentrant {
        balances[msg.sender] += amount;
        contract_balance += amount;
    }

    function withdraw(uint amount) public nonReentrant {
        require(amount > 0);
        require(amount <= balances[msg.sender]);

        balances[msg.sender] -= amount;

        contract_balance -= amount;
    }
}
