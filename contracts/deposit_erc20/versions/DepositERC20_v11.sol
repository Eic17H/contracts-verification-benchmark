// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

import "./lib/ERC20v1.sol";

/// @custom:version all methods do nothing, but revert when they should.
contract Deposit {
    ERC20 token;
    bool ever_deposited;

    uint private sent;
    uint initial_deposit;

    // ghost variables
    uint _count_deposit;

    constructor(ERC20 token_) {
        token = token_;
    }

    function deposit() public {
        require(!ever_deposited);	
    }

    function withdraw(uint amount) public {
    }
}
