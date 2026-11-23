rule always_wd_all_one {
    env e;

    deposit(e, 0);
    withdraw@withrevert(e, balanceOf(e, e.msg.sender));

    assert(!lastReverted);
    assert(balanceOf(e, e.msg.sender) == 0);
}
