/// @custom:version contract balance is a signed integer.
//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract ZeroTokenBank {
    int contract_balance;
    mapping (address => uint) balances;

    function abs(int n) private pure returns (uint) {
        if(n < 0) return uint256(-n);
        else return uint256(n);
    }

    function balanceOf(address addr) public view returns (uint) {
        return balances[addr];
    }

    function totalBalance() public view returns (uint) {
        return abs(contract_balance);
    }

    function deposit(uint amount) public {
        balances[msg.sender] += amount;
        contract_balance += int(amount);
    }

    function withdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balances[msg.sender]);

        balances[msg.sender] -= amount;

        contract_balance -= int(amount);
    }
}
