// after a non-reverting `withdraw`,
// the ETH balance of the Crowdfund contract is equal to zero.

function invariant(/* address payable user /* v11 */) public payable {
    
    require(block.number > end_donate);
    require(address(this).balance >= goal);
    require(msg.value == 0);
    
    withdraw();
    // withdraw(user); // v11

    assert(address(this).balance == 0);
}