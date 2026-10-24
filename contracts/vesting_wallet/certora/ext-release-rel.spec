// if the beneficiary is an externally owned account, after a successful call to `release`, the beneficiary receives `releasable()` ETH

ghost mathint reld;

hook CALL (uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if(addr == currentContract.beneficiary) reld = value;
}

rule ext_release_rel {
    env e;
    require e.msg.sender == e.tx.origin;
    mathint rels = releasable(e);
    release(e);
    // will fail if ETH is sent using multiple calls
    assert reld == rels;
}