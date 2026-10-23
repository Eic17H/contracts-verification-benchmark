// after a successful call to `release`, the beneficiary receives `releasable()` ETH

ghost mathint reld;

hook CALL (uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if(addr == currentContract.beneficiary) reld = value;
}

rule release_rel {
    env e;
    mathint rels = releasable(e);
    release(e);
    // will fail if ETH is sent using multiple calls
    assert reld == rels;
}