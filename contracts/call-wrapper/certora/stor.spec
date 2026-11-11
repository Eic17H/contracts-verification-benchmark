// the contract storage is unchanged after a call to `callwrap`.

rule stor {
    env e;
    address called;

    mathint before = currentContract.data;
    callwrap(e, called);
    mathint after = currentContract.data;

    assert before == after;
}
