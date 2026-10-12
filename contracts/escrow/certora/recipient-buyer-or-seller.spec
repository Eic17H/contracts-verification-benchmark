rule recipient_buyer_or_seller {
    env e;
    
    redeem(e);

    assert currentContract.recipient == currentContract.buyer || currentContract.recipient == currentContract.seller;
}
