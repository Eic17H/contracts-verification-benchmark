rule rel_strict_incr {
    mathint start = getStart();
    mathint duration = getDuration();
    
    env e1;
    env e2;
    // Avoid overflow when casting to uint64
    require e1.block.timestamp < 2^64;
    require e2.block.timestamp < 2^64;
    
    mathint releasable1 = releasable(e1);
    mathint balance1 = getBalance();
    mathint timestamp1 = e1.block.timestamp;
    mathint released1 = currentContract.released;
    

    mathint releasable2 = releasable(e2);
    mathint balance2 = getBalance();
    mathint timestamp2 = e2.block.timestamp;
    mathint released2 = currentContract.released;


    require balance1 == balance2 && released2 == released1;
    require start+duration > timestamp2 && timestamp2 > timestamp1 && timestamp1 > start;
    
    assert releasable2 > releasable1;
}
