// if the vesting scheme has expired, then exactly the whole contract balance is releasable.

function invariant() public view {
    require(block.timestamp > start + duration);
    assert(releasable() == address(this).balance);
}