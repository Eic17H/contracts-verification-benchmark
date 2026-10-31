// wd-transfer-to-owner:
// after a non-reverting `withdraw`, the ETH balance of owner is increased by an amount
// equal to the balance (of Crowdfund) before `withdraw` was called.

function invariant() public view {
    uint contractOldBalance = address(this).balance;
    uint ownerOldBalance = owner.balance;
    withdraw();
    uint ownerNewBalance = owner.balance;
    assert(ownerNewBalance - ownerOldBalance == contractOldBalance);
}