// the contract storage is unchanged after a call to `callwrap`.

// Yields false positives as it doesn't account for reentrant calls.

rule stor {
    env e;
    address called;

    mathint before = currentContract.data;
    callwrap(e, called);
    mathint after = currentContract.data;

    assert before == after;
}
