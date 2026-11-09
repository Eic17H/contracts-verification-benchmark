// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

import "./lib/ERC20v1.sol";

/// @custom:version `withdraw` always sends funds to depositor.
contract Deposit {
    ERC20 token;
    bool ever_deposited;

    uint private sent;
    uint initial_deposit;

    // ghost variables
    uint _count_deposit;

    address depositor;

    constructor(ERC20 token_) {
        token = token_;
    }

    function deposit() public {
        require(!ever_deposited);

        ever_deposited = true;
        uint allowance = token.allowance(msg.sender, address(this));
        token.transferFrom(msg.sender, address(this), allowance);

        initial_deposit = token.totalSupply();

        _count_deposit += 1;	

        depositor = msg.sender;
    }

    function withdraw(uint amount) public {
        sent += amount;
        token.transfer(depositor, amount);
    }
}
