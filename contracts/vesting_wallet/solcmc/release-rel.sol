// after a successful call to `release`, the beneficiary receives `releasable()` ETH

function invariant() public payable {
    uint rels = releasable();
    uint oldBalance = beneficiary.balance;
    release();
    uint newBalance = beneficiary.balance;
    assert(newBalance > rels);
    assert(oldBalance == newBalance - rels);
}