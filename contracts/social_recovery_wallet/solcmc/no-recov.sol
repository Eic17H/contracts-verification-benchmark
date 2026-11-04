// the recovery can never happen (should fail).

function invariant() public view {
    assert(_recovered == false);
}