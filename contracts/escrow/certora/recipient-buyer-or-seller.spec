// the recipient of the `redeem` call must be either the buyer or the seller.

rule recipient_buyer_or_seller {
    env e;
    method f;
    calldataarg args;

    // Calling a different method first, to ensure that redeem() is called in a state where it can be called
    require
        (  f.selector == sig:approve_payment().selector
        || f.selector == sig:refund().selector
        || f.selector == sig:open_dispute().selector
        || f.selector == sig:arbitrate(address).selector);

    f(e,args);

    redeem(e);
    
    assert
        (  currentContract.recipient == currentContract.buyer
        || currentContract.recipient == currentContract.seller);

}
