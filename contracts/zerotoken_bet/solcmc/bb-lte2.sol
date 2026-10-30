// the balance of player B does not exceed 2 tokens

function invariant() public view {
    assert (balance_b <= 2);
}
