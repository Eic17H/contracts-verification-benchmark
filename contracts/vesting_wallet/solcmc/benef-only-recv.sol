// only the beneficiary can receive ETH from the contract

function invariant(uint f) public payable {
    uint oldBalance = msg.sender.balance;
    release();
    uint newBalance = msg.sender.balance;
    assert(oldBalance == newBalance || msg.sender == beneficiary);
}