// if the donation period has not ended
// and there is a non-reverting `donate` transaction by user A,
// then `donation[A]` is not decreased.

function invariant() public payable {
    require(block.number <= end_donate);

    uint donorBefore = donation[msg.sender];

    donate(); 

    assert(donation[msg.sender] >= donorBefore);
}