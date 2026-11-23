rule always_wd_all_one {
    env e;

    deposit(e, 0);
    withdraw@withrevert(e, nativeBalances[e.msg.sender]);

    assert(!lastReverted);
    assert(nativeBalances[e.msg.sender] == 0);
}
