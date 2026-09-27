// Wrong

function invariant() public {
    require(state == State.REDEEM);
    uint buyerBalance = address(buyer).balance;
    uint sellerBalance = address(seller).balance;
    redeem();
    assert(address(buyer).balance == buyerBalance + fee || address(seller).balance == sellerBalance + fee);
}