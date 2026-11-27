// in the Agree state, both the buyer and the seller can open a dispute.

/// @custom:negate

function invariant(uint f) public {
    
    require(state == State.AGREE);

    require(msg.sender == buyer || msg.sender == seller);
    require (arbiter != buyer);
    require (arbiter != seller);
    require (buyer != seller);
    
    // it reverts in v8 and becomes vacuous
    open_dispute();

    assert(state != State.DISPUTE);
}