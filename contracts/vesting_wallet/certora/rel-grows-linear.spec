// Wrong (due to integer truncation)

rule rel_grows_linear {

    mathint start = getStart();
    mathint duration = getDuration();
    
    env e1;
    env e2;
    env e3;
    // Avoid overflow when casting to uint64
    require e1.block.timestamp < 2^64;
    require e2.block.timestamp < 2^64;
    require e3.block.timestamp < 2^64;


    
    mathint releasable1 = releasable(e1);
    mathint balance1 = getBalance();
    mathint timestamp1 = e1.block.timestamp;
    mathint released1 = currentContract.released;
    

    mathint releasable2 = releasable(e2);
    mathint balance2 = getBalance();
    mathint timestamp2 = e2.block.timestamp;
    mathint released2 = currentContract.released;


    mathint releasable3 = releasable(e3);
    mathint balance3 = getBalance();
    mathint timestamp3 = e3.block.timestamp;
    mathint released3 = currentContract.released;
    
    // An attempt to fix the truncation problem
    require balance1 + released1 >= duration;
    require balance2 + released2 >= duration;
    require balance3 + released3 >= duration;


    require balance1 == balance2 && released2 == released1 && balance2 == balance3 && released2 == released3;
    require start < timestamp1 && timestamp1 < timestamp2 && timestamp2 < timestamp3 && timestamp3 < start+duration;
    
    // A*D==C*D instead of A/B==C/D to avoid truncation
    // Still too much margin of error as in rel-strict-incr
    assert (releasable2 - releasable1)*(timestamp3 - timestamp2) == (releasable3 - releasable2)*(timestamp2 - timestamp1);
}