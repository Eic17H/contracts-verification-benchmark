// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `withdraw` won't send the full contract balance, new `withdrawAll` method sends the full contract balance.
contract DepositEth {

    uint private sent;
    uint public immutable initial_deposit;

    constructor () payable {
        initial_deposit = address(this).balance;
    }

    function withdraw(uint amount) public {
        require(amount + 1 <= address(this).balance);

        sent += amount;

        (bool succ,) = msg.sender.call{value: amount}("");
        require(succ);	
    }

    function withdrawAll() public {
        sent += address(this).balance;
        (bool succ,) = msg.sender.call{value: address(this).balance}("");
        require(succ);	
    }
}
