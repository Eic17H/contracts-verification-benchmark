// if the beneficiary is an externally owned account, after a successful call to `release`, the beneficiary receives `releasable()` ETH

function invariant() public payable {
    // Will recognize a contract constructor as an EOA
    require (beneficiary.code.length > 0);

    uint rels = releasable();
    uint oldBalance = beneficiary.balance;
    release();
    uint newBalance = beneficiary.balance;
    assert(oldBalance + rels == newBalance);
}