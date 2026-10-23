hook CALL (uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if(value > 0)
        assert(addr == currentContract.beneficiary);
}

rule benef_only_recv {
    method f;
    calldataarg args;
    env e;
    f(e, args);
    assert(true);
}