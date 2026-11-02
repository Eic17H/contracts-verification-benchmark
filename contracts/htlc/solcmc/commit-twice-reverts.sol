// After a succesful `commit()` call, any immediately following calls to `commit()` must revert

function invariant(bytes32 h1, bytes32 h2) public {
    commit(h1);
    commit(h2);
    assert(false);
}