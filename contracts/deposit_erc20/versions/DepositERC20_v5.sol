// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

import "./lib/ERC20v1.sol";

/// @custom:version can deposit exactly twice.
contract Deposit {
    ERC20 token;
    uint times_deposited;

    uint private sent;
    uint initial_deposit;

    // ghost variables
    uint _count_deposit;

    constructor(ERC20 token_) {
        token = token_;
        times_deposited = 0;
    }

    function deposit() public {
        require(times_deposited < 2);

        times_deposited += 1;
        uint allowance = token.allowance(msg.sender, address(this));
        token.transferFrom(msg.sender, address(this), allowance);

        initial_deposit = token.totalSupply();

        _count_deposit += 1;	
    }

    function withdraw(uint amount) public {
        sent += amount;
        token.transfer(msg.sender, amount);
    }
}
