// if an address `addr` has participated in a recovery,
// then `addr` is a guardian.
// Should fail in v1 because guardians can be removed.

function invariant(address a) public view {
    require(guardianToRecovery[a].proposedOwner != address(0));
    assert(isGuardian[keccak256(abi.encodePacked(a))] == true);
}