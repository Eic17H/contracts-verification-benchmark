// calls to `withdraw` will revert if the contract balance is less than the `goal`.

function invariant(/* address payable _user /* v11 */) public payable {
    require(address(this).balance < goal);
    require(msg.value == 0);

    withdraw();
    // withdraw(_user); // v11

    assert(false);
}
