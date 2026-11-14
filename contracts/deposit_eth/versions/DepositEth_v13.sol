// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `withdraw` transfers `amount-1` instead of `amount`.
contract DepositEth {

    uint private sent;
    uint public immutable initial_deposit;

    constructor () payable {
        initial_deposit = address(this).balance;
    }

    function withdraw(uint amount) public {
        require(amount - 1 <= address(this).balance);

        sent += amount - 1;

	    (bool succ,) = msg.sender.call{value: amount-1}("");
        require(succ);
    }

}
