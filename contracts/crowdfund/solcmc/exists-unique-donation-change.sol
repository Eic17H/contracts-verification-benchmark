// after a non-reverting `donate` transaction to the Crowdfund contract,
// the donation of exactly one user has changed.

function invariant(address donor, address other) public payable {
    require(block.number <= end_donate);
    require(donation[donor] <= type(uint256).max - msg.value);
    require(msg.sender == donor);
    require(donor != other);

    uint donationBefore = donation[donor];
    uint otherBefore = donation[other];

    donate();

    assert(donation[donor] != donationBefore);
    assert(donation[other] == otherBefore);
}