// releasable grows linearly between the start of the vesting scheme and its expiration

// Wrong

// TODO: use arguments as timestamps instead of generating them (time doesn't pass inside the invariant)
function invariant() public view {
    // block.timestamp < start => releasable() == 0
    // assert(!(block.timestamp < start) || releasable() <= 0);

    require(start < uint64(block.timestamp));
    uint64 timestamp1 = uint64(block.timestamp);
    uint256 releasable1 = releasable();
    uint balance = address(this).balance;

    require(timestamp1 < uint64(block.timestamp));
    uint64 timestamp2 = uint64(block.timestamp);
    uint256 releasable2 = releasable();
    require(balance == address(this).balance);
    require(releasable1 < releasable2);

    require(timestamp2 < uint64(block.timestamp));
    uint64 timestamp3 = uint64(block.timestamp);
    uint256 releasable3 = releasable();
    require(balance == address(this).balance);
    require(releasable2 < releasable3);

    require(timestamp3 < start+duration);
    
    assert((releasable2 - releasable1)*(timestamp3 - timestamp2) == (releasable3 - releasable2)*(timestamp2 - timestamp1));
}
