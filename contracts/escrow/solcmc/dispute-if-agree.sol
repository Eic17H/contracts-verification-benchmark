// in the Agree state, both the buyer and the seller can open a dispute.

function invariant(uint f) public view {
    
    require(state == State.AGREE);

    require(msg.sender == buyer || msg.sender == seller);
    
    // it reverts in v8 and becomes vacuous
    open_dispute();

    assert(state == State.DISPUTE);
}