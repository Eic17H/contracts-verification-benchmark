// the balance of player B is always nonnegative

function invariant() public view {
    assert (balance_b >= 0);
}
