// Won't work, as the arbiter can forward the ETH to a different address before the final assertion.

function invariant(address dst, uint f) public {

    if(f==0) require (arbiter == seller);
    else if(f==1) require (arbiter != seller);
    else require(false);

    // Arbitrate requires Dispute state
    require(state == State.DISPUTE);
    require(fee > 0);
    // require(msg.sender == arbiter);
    // require(dst == buyer || dst == seller);

    // Balances before the arbitrate
    uint thisBefore = address(this).balance;
    uint arbiterBefore = address(arbiter).balance;

    arbitrate(dst);

    // Immediately after the arbitrate
    require(state == State.REDEEM);
    
    // Balances after the arbitrate
    uint thisAfter = address(this).balance;
    uint arbiterAfter = address(arbiter).balance;

    // The fee must have been transfered from this to arbiter
    assert(thisBefore - thisAfter == fee);
    assert(arbiterAfter - arbiterBefore == fee);
}