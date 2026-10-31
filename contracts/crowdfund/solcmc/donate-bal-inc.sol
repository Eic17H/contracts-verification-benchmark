// a non-reverting call to `donate` does not decrease the balance of the contract.

function invariant() public payable {
    
    require(block.number <= end_donate);

    uint oldBalance = address(this).balance;

    donate();
    // if the call reverts the rule passes

    assert(oldBalance <= address(this).balance);

}