rule redeem_send {
    env e;
    method f;
    calldataarg args;

    require(e.msg.sender != currentContract);

    // trivial checks to rule out unrealistic scenarios
    require(currentContract.buyer != currentContract);
    require(currentContract.seller != currentContract);

    require
        (  f.selector == sig:approve_payment().selector
        || f.selector == sig:refund().selector
        || f.selector == sig:open_dispute().selector
        || f.selector == sig:arbitrate(address).selector);
    f(e,args);

    mathint oldbal_b = nativeBalances[currentContract.buyer];
    mathint oldbal_s = nativeBalances[currentContract.seller];

    redeem(e);

    mathint newbal_b = nativeBalances[currentContract.buyer];
    mathint newbal_s = nativeBalances[currentContract.seller];

    mathint sent_b = newbal_b - oldbal_b;
    mathint sent_s = newbal_s - oldbal_s;

    assert
        ( sent_b == to_mathint(currentContract.deposit)
        || sent_s == to_mathint(currentContract.deposit));
}
