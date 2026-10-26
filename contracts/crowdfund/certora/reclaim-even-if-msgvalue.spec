
/// reclaim-even-if-msgvalue:
/// for a call to `reclaim` by `msg.sender` A, the call executes
/// as expected even if `msg.value` is non-zero.

/// @custom:negate
// This test will pass if the contract always accepts calls to `reclaim` with `msg.value>0`
// With `assert !lastReverted` and no `@custom:negate`, a test would fail if there was
// any way for `reclaim` to revert with `msg.value>0`, even for unrelated reasons,
// such as a sender that rejects ETH.

rule reclaim_even_if_msgvalue {
    env e;

    require(e.block.number > currentContract.end_donate);
    require(nativeBalances[currentContract] < currentContract.goal);
    require(currentContract.donation[e.msg.sender] > 0);
    
    require(e.msg.value > 0);

    reclaim@withrevert(e);

    assert lastReverted;
}