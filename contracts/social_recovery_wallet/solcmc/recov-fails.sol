// `executeRecovery()` will fail if not enough guardians have joined the recovery process.

/// @custom:ghost
address oldOwner;
address newOwner;
address[] guardianList;

/// @custom:preghost function executeRecovery
require(guardianList.length < threshold); // line 112 in v1
require(inRecovery == true); // modifier onlyInRecovery
require(owner != newOwner);
for (uint i = 0; i < guardianList.length; i++) {
    //require(isGuardian[keccak256(abi.encodePacked(guardianList[i]))] == true); // check that the guardian list makes sense
    require(guardianToRecovery[guardianList[i]].recoveryRound == currRecoveryRound); // line 119 in v1
    require(guardianToRecovery[guardianList[i]].proposedOwner == newOwner); // line 120 in v1
    require(!guardianToRecovery[guardianList[i]].usedInExecuteRecovery); // line 121 in v1
}

/// @custom:postghost function executeRecovery
assert(owner == oldOwner);

/// @custom:invariant
function invariant(address newOwner_, address[] calldata guardianList_) public {
    oldOwner = owner;
    newOwner = newOwner_;
    guardianList = guardianList_;
}