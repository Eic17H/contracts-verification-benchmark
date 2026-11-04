// the recovery can never happen (should fail).

rule no_recov {
    env e;
    calldataarg args;
    executeRecovery(e, args);
    assert(false);
}