// releasable grows linearly between the start of the vesting scheme and its expiration:
// two successful consequent calls to `releasable` differ by c*t,
// where t is the timestamp difference between the two calls,
// and c is a fixed constant for the contract

rule rel_grows_linear {

    mathint start = currentContract.start;
    mathint duration = currentContract.duration;
    
    // Get three moments in time
    env e1;
    env e2;
    env e3;
    // Avoid overflow when casting to uint64
    require e1.block.timestamp < 2^64;
    require e2.block.timestamp < 2^64;
    require e3.block.timestamp < 2^64;


    // Get data from the three environments
    
    mathint r1 = currentContract.releasable(e1);
    mathint b1 = nativeBalances[currentContract];
    mathint t1 = e1.block.timestamp;
    mathint rd1 = currentContract.released;

    mathint r2 = currentContract.releasable(e2);
    mathint b2 = nativeBalances[currentContract];
    mathint t2 = e2.block.timestamp;
    mathint rd2 = currentContract.released;

    mathint r3 = currentContract.releasable(e3);
    mathint b3 = nativeBalances[currentContract];
    mathint t3 = e3.block.timestamp;
    mathint rd3 = currentContract.released;

    // Ensure only the timestamp and releasable have changed
    require b1 == b2;
    require rd2 == rd1;
    require b2 == b3;
    require rd2 == rd3;

    // Ensure the timestamps are in the correct order
    require      start < t1;
    require t1 < t2;
    require t2 < t3;
    require t3 < start+duration;

    /* Attempt to correct for integer truncation
    mathint tdiff1 = t2 - t1;
    mathint tdiff2 = t3 - t2;
    mathint rdiff1 = r2 - r1;
    mathint rdiff2 = 3 - r2;
    
    mathint cross = rdiff1 * tdiff2 - rdiff2 * tdiff1;
    mathint tolerance = tdiff1 + tdiff2;

    assert -tolerance < cross && cross < tolerance;
    */

    mathint c;
    assert r1>r2 => t1>t2;
    assert r1<r2 => t1<t2;
    assert r1>r2 => t2>t3;
    assert r1<r2 => t2<t3;
    assert r2>r3 => t2>t3;
    assert r2<r3 => t2<t3;

    require r2-r1 == c*(t2-t1);
    assert r3-r2 == c*(t3-t2);
}