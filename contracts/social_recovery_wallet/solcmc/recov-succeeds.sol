// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

/// @custom:negate

/// @custom:ghost
address newOwner;
address[] guardianList;

/// @custom:preghost function executeRecovery
require(guardianList.length >= threshold); // line 112 in v1
require(inRecovery == true); // modifier onlyInRecovery
for (uint i = 0; i < guardianList.length; i++) {
    //require(isGuardian[keccak256(abi.encodePacked(guardianList[i]))] == true); // check that the guardian list makes sense
    require(guardianToRecovery[guardianList[i]].recoveryRound == currRecoveryRound); // line 119 in v1
    require(guardianToRecovery[guardianList[i]].proposedOwner == newOwner); // line 120 in v1
    require(!guardianToRecovery[guardianList[i]].usedInExecuteRecovery); // line 121 in v1
}

/// @custom:postghost function executeRecovery
assert(owner != newOwner);

/// @custom:invariant
function invariant(address newOwner_, address[] calldata guardianList_) public {
    newOwner = newOwner_;
    guardianList = guardianList_;
}