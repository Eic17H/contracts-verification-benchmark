rule always_bal_to_max {
    env e;

    uint amount = assert_uint256(max_uint256 - nativeBalances[e.msg.sender]);
    deposit@withrevert(e, amount);

    assert(!lastReverted);
    assert(nativeBalances[e.msg.sender] == max_uint256);
}
