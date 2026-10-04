// only the beneficiary can receive ETH from the contract

function invariant(address callerAddress) public payable {
    require(msg.sender == callerAddress);
    require(msg.sender != beneficiary);
    uint oldBalance = callerAddress.balance;
    release();
    uint newBalance = callerAddress.balance;
    assert(oldBalance == newBalance);
}