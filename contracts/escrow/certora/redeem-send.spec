ghost mathint sent_b;
ghost mathint sent_s;

hook CALL(uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    // The value of `sent` can be havocked before the call, so it cannot be an accumulator.
    // The test will fail if the ETH is sent with multiple calls.
    if (addr == currentContract.buyer) {
        sent_b = value;
    }
    if (addr == currentContract.seller) {
        sent_s = value;
    }
}

rule redeem_send {
    env e;
    method f;
    calldataarg args;

    require
        (  f.selector == sig:approve_payment().selector
        || f.selector == sig:refund().selector
        || f.selector == sig:open_dispute().selector
        || f.selector == sig:arbitrate(address).selector);
    f(e,args);

    redeem(e);

    assert
        ( sent_b == to_mathint(currentContract.deposit)
        || sent_s == to_mathint(currentContract.deposit));
}
