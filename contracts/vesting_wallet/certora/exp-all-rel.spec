// if the vesting scheme has expired, then exactly the whole contract balance is releasable.

rule exp_all_rel {
    env e;

    // Making values fit in uint64
    mathint current_timestamp = e.block.timestamp;
    require current_timestamp < 2^64;
    mathint ending_timestamp = currentContract.start + currentContract.duration;
    require ending_timestamp < 2^64;
    
    require current_timestamp > ending_timestamp;

    assert currentContract.releasable(e) == nativeBalances[currentContract];
}
