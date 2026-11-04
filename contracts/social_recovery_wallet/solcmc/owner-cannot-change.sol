// the first owner is always the owner, in other words: the owner cannot change (should fail).

function invariant() public view {
    assert(owner == _first_owner);
}