// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version no `deposit` variable.

contract Escrow {
    enum State {AGREE, DISPUTE, REDEEM, END}

    State state;

    address immutable buyer;
    address immutable seller;
    address immutable arbiter;
    address recipient;

    uint immutable fee;

    modifier instate(State _state) {
        require(state == _state);
        _;
    }

    constructor(address seller_, address arbiter_, uint fee_) payable {
        require (seller_ != address(0) && arbiter_ != address(0));
        require(fee_ <= msg.value);
        buyer = msg.sender;
        seller = seller_;
        arbiter = arbiter_;
        fee = fee_;
        state = State.AGREE;
    }

    function approve_payment() public instate(State.AGREE) {
        require(msg.sender == buyer);
        recipient = seller;
        state = State.REDEEM;
    }

    function refund() public instate(State.AGREE) {
        require(msg.sender == seller);
        recipient = buyer;
        state = State.REDEEM;
    }

    function open_dispute() public instate(State.AGREE) {
        require(msg.sender == seller || msg.sender == buyer);
        state = State.DISPUTE;
    }

    function arbitrate(address recipient_) public instate(State.DISPUTE) {
        require(msg.sender == arbiter);
        require(recipient_ == buyer || recipient_ == seller);
        recipient = recipient_;
        (bool success,) = arbiter.call{value: fee}("");
        require(success);
        state = State.REDEEM;
    }

    function redeem() public instate(State.REDEEM) {
        require(msg.sender == recipient);
        (bool success,) = recipient.call{value: address(this).balance}("");
        require(success);
        state = State.END;
    }
}