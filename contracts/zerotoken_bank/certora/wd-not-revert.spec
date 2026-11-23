rule wd_not_revert {
    env e;
    uint amount;

    require(amount <= balanceOf(e, e.msg.sender));

    withdraw@withrevert(e, amount);

    assert(!lastReverted);
}
