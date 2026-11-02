// After a succesful `commit()` call, any immediately following calls to `commit()` must revert

function invariant(bytes32 h) public {
    commit(h);
    commit(h);
    assert(false);
}