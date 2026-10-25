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
    
    mathint releasable1 = currentContract.releasable(e1);
    mathint balance1 = nativeBalances[currentContract];
    mathint timestamp1 = e1.block.timestamp;
    mathint released1 = currentContract.released;

    mathint releasable2 = currentContract.releasable(e2);
    mathint balance2 = nativeBalances[currentContract];
    mathint timestamp2 = e2.block.timestamp;
    mathint released2 = currentContract.released;

    mathint releasable3 = currentContract.releasable(e3);
    mathint balance3 = nativeBalances[currentContract];
    mathint timestamp3 = e3.block.timestamp;
    mathint released3 = currentContract.released;

    // Ensure only the timestamp and releasable have changed
    require balance1 == balance2;
    require released2 == released1;
    require balance2 == balance3;
    require released2 == released3;

    // Ensure the timestamps are in the correct order
    require      start < timestamp1;
    require timestamp1 < timestamp2;
    require timestamp2 < timestamp3;
    require timestamp3 < start+duration;

    mathint tdiff1 = timestamp2 - timestamp1;
    mathint tdiff2 = timestamp3 - timestamp2;
    mathint rdiff1 = releasable2 - releasable1;
    mathint rdiff2 = releasable3 - releasable2;
    
    mathint cross = rdiff1 * tdiff2 - rdiff2 * tdiff1;
    mathint tolerance = tdiff1 + tdiff2;

    assert -tolerance < cross && cross < tolerance;
}