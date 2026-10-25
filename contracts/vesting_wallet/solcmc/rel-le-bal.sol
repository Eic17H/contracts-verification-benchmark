// the amount of releasable tokens is always <= the contract balance

function invariant() public view {
    uint balance = address(this).balance;
    uint releasable = releasable();
    assert(releasable <= balance);
}
