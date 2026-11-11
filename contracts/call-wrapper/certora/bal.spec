// the contract balance is unchanged after a call to `callwrap`.

rule bal {
    env e;
    address called;

    mathint before = nativeBalances[currentContract];
    callwrap(e, called);
    mathint after = nativeBalances[currentContract];

    assert before == after;
}
