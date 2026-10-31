// in the Agree state, only the buyer and the seller can perform actions.

function invariant(uint f, address dst) public view {
    if (f==0)
        approve_payment();
    else if (f==1)
        refund();
    else if (f==2)
        open_dispute();
    else if (f==3)
        arbitrate(dst);
    else
        redeem();
    assert(msg.sender == buyer || msg.sender == seller);
}
