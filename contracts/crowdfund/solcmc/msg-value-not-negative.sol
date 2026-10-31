// the `msg.value` for a call to `donate` should not be negative.

function invariant() public payable {

    donate();

    assert(msg.value >= 0);
}