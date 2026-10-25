// if the vesting scheme has expired, then exactly the whole contract balance is releasable.

function invariant(uint64 timestamp) public view {
    require(block.timestamp < 2**64);
    require(block.timestamp > start + duration);
    assert(releasable() == address(this).balance);
}
