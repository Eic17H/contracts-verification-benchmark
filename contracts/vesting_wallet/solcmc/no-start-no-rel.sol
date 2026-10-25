// if the vesting scheme has not started yet, then no balance is releasable

function invariant() public view {
    require(block.timestamp < start);
    assert(releasable() <= 0);
}
