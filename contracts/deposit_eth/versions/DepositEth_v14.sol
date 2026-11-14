// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `withdraw` transfers `amount-1` instead of `amount`, except if `amount` is equal to the contract balance.
contract DepositEth {

    uint private sent;
    uint public immutable initial_deposit;

    constructor () payable {
        initial_deposit = address(this).balance;
    }

    function withdraw(uint amount) public {
        if(amount > 0 && amount != address(this).balance) amount = amount - 1;
        require(amount <= address(this).balance);

        sent += amount;

	    (bool succ,) = msg.sender.call{value: amount}("");
        require(succ);
    }

}
