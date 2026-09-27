// Wrong

function invariant(uint f) public {
    // Dispute requires Agree state
    require(state == State.AGREE);

    // Three possible senders
    if(f==0) {
        require(msg.sender == buyer);
    } else if(f==1) {
        require(msg.sender == seller);
    } else if(f==2) {
        require(msg.sender == arbiter);
    } else {
        require(false);
    }
    
    open_dispute();

    // If the dispute has been opened, the sender must be either the buyer or the seller.
    assert((f==0 || f==1) && state == State.DISPUTE || f==2 && state != State.DISPUTE);
}