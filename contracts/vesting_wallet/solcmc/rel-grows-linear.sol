// Wrong (due to integer truncation)

// releasable grows linearly between the start of the vesting scheme and its expiration
function invariant(uint256 total, uint64 t1, uint64 t2, uint64 t3) public view {

    require(start <= t1);
    require(t1 < t2);
    require(t2 < t3);
    require(t3 <= start + duration);

    uint256 r1 = vestingSchedule(total, t1);
    uint256 r2 = vestingSchedule(total, t2);
    uint256 r3 = vestingSchedule(total, t3);

    assert((r2 - r1)*(t3 - t2) == (r3 - r2)*(t2 - t1));
}