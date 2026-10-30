// the balance of player A does not exceed 2 tokens

function invariant() public view {
    assert (balance_a <= 2);
}
