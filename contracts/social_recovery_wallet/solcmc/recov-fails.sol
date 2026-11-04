// `executeRecovery()` will fail if not enough guardians have joined the recovery process.

function invariant(address newOwner, address[] calldata guardianList) public {
    require(guardianList.length < threshold);
    require(owner != newOwner);

    for (uint i = 0; i < guardianList.length; i++) {
        require(isGuardian[keccak256(abi.encodePacked(guardianList[i]))] == true);
        require(guardianToRecovery[guardianList[i]].proposedOwner == newOwner);
        require(guardianToRecovery[guardianList[i]].recoveryRound == currRecoveryRound);
    }

    bool recoverySuccess = executeRecovery(newOwner, guardianList);

    assert(!recoverySuccess);
    assert(owner != newOwner);
}