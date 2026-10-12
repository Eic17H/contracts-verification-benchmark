ghost mathint sent_b;
ghost mathint sent_s;

hook CALL(uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if (addr == currentContract.buyer) {
        sent_b = sent_b + value;
    }
    if (addr == currentContract.seller) {
        sent_s = sent_s + value;
    }
}

rule arbitrate_send {
    env e;

    require(sent_b == 0 && sent_s == 0);

    mathint deposit = currentContract.deposit;
    redeem(e);

    assert (sent_b == deposit || sent_s == deposit);
}
