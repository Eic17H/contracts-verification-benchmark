/// @custom:version balances are signed integers.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract ZeroTokenBank {
    uint contract_balance;
    mapping (address => int) balances;

    function abs(int n) private pure returns (uint) {
        if(n < 0) return uint256(-n);
        else return uint256(n);
    }

    function balanceOf(address addr) public view returns (uint) {
        return abs(balances[addr]);
    }

    function totalBalance() public view returns (uint) {
        return contract_balance;
    }

    function deposit(uint amount) public {
        balances[msg.sender] += int(amount);
        contract_balance += amount;
    }

    function withdraw(uint amount) public {
        require(amount > 0);
        require(amount <= abs(balances[msg.sender]));

        balances[msg.sender] -= int(amount);

        contract_balance -= amount;
    }
}
