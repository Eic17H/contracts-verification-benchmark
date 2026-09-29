// if the vesting scheme has expired, that the whole contract balance is releasable

function invariant(uint64 timestamp) public view {
    // block.timestamp > start + duration => releasable() >= address(this).balance
    assert(vestedAmount(timestamp) - released == address(this).balance);
}
