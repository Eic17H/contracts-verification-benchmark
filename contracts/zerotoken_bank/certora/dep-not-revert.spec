rule dep_not_revert {
    env e;
    uint amount;

    deposit@withrevert(e, amount);

    assert(!lastReverted);
}
