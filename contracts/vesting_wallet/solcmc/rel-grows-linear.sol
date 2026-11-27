// releasable grows linearly between the start of the vesting scheme and its expiration:
// two successful consequent calls to `releasable` differ by c*t,
// where t is the timestamp difference between the two calls,
// and c is a fixed constant for the contract

function invariant(uint256 total, uint64 t1, uint64 t2, uint64 t3, uint c) public view {

    require(start <= t1);
    require(t1 < t2);
    require(t2 < t3);
    require(t3 <= start + duration);

    uint256 r1 = vestingSchedule(total, t1);
    uint256 r2 = vestingSchedule(total, t2);
    uint256 r3 = vestingSchedule(total, t3);

    /* Attempt to correct for integer truncation
    uint tdiff1 = t2 - t1;
    uint tdiff2 = t3 - t2;
    uint rdiff1 = r2 - r1;
    uint rdiff2 = r3 - r2;

    uint cross;
    if(rdiff1 * tdiff2 > rdiff2 * tdiff1)
        cross = rdiff1 * tdiff2 - rdiff2 * tdiff1;
    else
        cross = rdiff2 * tdiff1 - rdiff1 * tdiff2;
    uint tolerance = tdiff1 + tdiff2;

    assert (cross < tolerance);
    */

    // Check that gradient signs match
    assert(r2<r1||t2>t1);
    assert(r2>r1||t2<t1);
    assert(r3<r2||t3>t2);
    assert(r3>r2||t3<t2);
    assert(r2<r1||r2<r3);
    assert(r2>r1||r2>r3);

    // Avoid reverting due to underflow
    if(r2>r1) require(r2-r1 == c*(t2-t1));
    else require(r1-r2 == c*(t1-t2));
    if(r3>r2) assert(r3-r2 == c*(t3-t2));
    else assert(r2-r3 == c*(t2-t3));
}