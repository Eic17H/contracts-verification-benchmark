// before the expiration of the scheme and after the start of the vesting scheme,
// the releasable amount is strictly increasing
// whenever the contract balance and the released amount is constant.

function invariant(uint64 timestamp1, uint64 timestamp2) public view {

    require(start + duration > timestamp2);
    require(timestamp2 > timestamp1);
    require(timestamp1 > start);

    uint releasable1 = vestedAmount(timestamp1);
    uint releasable2 = vestedAmount(timestamp2);

    // Avoid timestamps being so close that releasable1==releasable2 despite the function being strictly increasing.
    // Will not work with function that grow faster than linearly.
    require((address(this).balance + released) * (timestamp2 - timestamp1) >= duration);

    assert(releasable2 > releasable1);
}