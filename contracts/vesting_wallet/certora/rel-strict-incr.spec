// before the expiration of the scheme and after the start of the vesting scheme,
// the releasable amount is strictly increasing
// whenever the contract balance and the released amount is constant.

rule rel_strict_incr {
    mathint start = currentContract.start;
    mathint duration = currentContract.duration;
    
    env e1;
    env e2;
    // Avoid overflow when casting to uint64
    require e1.block.timestamp < 2^64;
    require e2.block.timestamp < 2^64;
    
    mathint releasable1 = currentContract.releasable(e1);
    mathint balance1 = nativeBalances[currentContract];
    mathint timestamp1 = e1.block.timestamp;
    mathint released1 = currentContract.released;
    

    mathint releasable2 = currentContract.releasable(e2);
    mathint balance2 = nativeBalances[currentContract];
    mathint timestamp2 = e2.block.timestamp;
    mathint released2 = currentContract.released;


    require balance1 == balance2 && released2 == released1;
    require start+duration > timestamp2 && timestamp2 > timestamp1 && timestamp1 > start;

    // Avoid timestamps being so close that releasable1==releasable2 despite the function being strictly increasing.
    // Will not work with function that grow faster than linearly.
    require (balance1+released1) * (timestamp2 - timestamp1) >= duration;
    
    assert releasable2 > releasable1;
}
