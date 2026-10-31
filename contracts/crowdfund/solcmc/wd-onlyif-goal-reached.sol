// after a non-reverting `withdraw`,
// the balance of the contract before the transaction
// must have been greater or equal to the `goal`.

function invariant(/* address payable user /* v11 */) public payable {
    
    require(block.number > end_donate);
    require(msg.value == 0);

    uint balanceBefore = address(this).balance;

    withdraw();
    // withdraw(user); // v1

    assert(balanceBefore >= goal);

}