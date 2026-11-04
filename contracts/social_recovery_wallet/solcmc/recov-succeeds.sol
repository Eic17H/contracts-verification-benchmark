// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

function invariant(address newOwner, address[] calldata guardianList) public {

    require(guardianList.length >= threshold);
    require(inRecovery == true);

    for (uint i = 0; i < guardianList.length; i++) {
        require(isGuardian[keccak256(abi.encodePacked(guardianList[i]))] == true);
        require(guardianToRecovery[guardianList[i]].proposedOwner == newOwner);
        require(guardianToRecovery[guardianList[i]].recoveryRound == currRecoveryRound);
    }

    bool recoverySuccess = executeRecovery(newOwner, guardianList);

    assert(recoverySuccess);
    assert(owner == newOwner);
}