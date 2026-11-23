rule wd_not_revert {
    env e;
    uint amount;

    require(amount <= nativeBalances[e.msg.sender]);

    withdraw@withrevert(e, amount);

    assert(!lastReverted);
}
