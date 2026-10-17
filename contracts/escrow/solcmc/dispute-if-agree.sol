// Wrong

function invariant(uint f) public {
    // Dispute requires Agree state
    require(state == State.AGREE);

    require(msg.sender == buyer || msg.sender == seller);
    
    // TODO: I think it reverts in v8 and becomes vacuous
    open_dispute();

    // If the dispute has been opened, the sender must be either the buyer or the seller.
    assert(state == State.DISPUTE);
}