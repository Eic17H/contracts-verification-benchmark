rule exp_all_rel {
    env e;

    mathint current_timestamp = e.block.timestamp;
    mathint ending_timestamp = currentContract.start + currentContract.duration;
    
    require current_timestamp > ending_timestamp;

    assert currentContract.releasable(e) == nativeBalances[currentContract];
}
