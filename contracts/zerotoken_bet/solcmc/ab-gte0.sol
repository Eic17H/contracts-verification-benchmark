// the balance of player A is always nonnegative

function invariant() public view {
    assert (balance_a >= 0);
}
