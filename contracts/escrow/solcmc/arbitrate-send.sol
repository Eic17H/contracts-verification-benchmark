// Wrong

function invariant(address dst) public {

    // Arbitrate requires Dispute state
    require(state == State.DISPUTE);
    require(msg.sender == arbiter);
    require(dst == buyer || dst == seller);

    // Balances before the arbitrate
    uint thisBefore = address(this).balance;
    uint arbiterBefore = address(arbiter).balance;

    arbitrate(dst);
    
    // Balances after the arbitrate
    uint thisAfter = address(this).balance;
    uint arbiterAfter = address(arbiter).balance;

    // The fee must have been transfered from this to arbiter
    assert(thisBefore - thisAfter == fee && arbiterAfter - arbiterBefore == fee);
}