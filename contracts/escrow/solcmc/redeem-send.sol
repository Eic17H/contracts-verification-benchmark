// after a successful call to `redeem`, either the buyer or the seller receives `deposit` ETH.

function invariant() public view {
    uint buyerBalance = address(buyer).balance;
    uint sellerBalance = address(seller).balance;
    redeem();
    assert(address(buyer).balance == buyerBalance + fee || address(seller).balance == sellerBalance + fee);
}