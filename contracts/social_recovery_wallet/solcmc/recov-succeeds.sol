// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

/// @custom:negate

/// @custom:ghost
address newOwner_;
address[] guardianList_;

/// @custom:preghost function executeRecovery
require(guardianList_.length >= threshold); // line 112 in v1
require(inRecovery == true); // modifier onlyInRecovery
for (uint i = 0; i < guardianList_.length; i++) {
    //require(isGuardian[keccak256(abi.encodePacked(guardianList_[i]))] == true); // check that the guardian list makes sense
    require(guardianToRecovery[guardianList_[i]].recoveryRound == currRecoveryRound); // line 119 in v1
    require(guardianToRecovery[guardianList_[i]].proposedOwner == newOwner_); // line 120 in v1
    require(!guardianToRecovery[guardianList_[i]].usedInExecuteRecovery); // line 121 in v1
}

/// @custom:postghost function executeRecovery
assert(owner != newOwner_);

/// @custom:invariant
function invariant(address newOwnerParam, address[] calldata guardianListParam) public {
    newOwner_ = newOwnerParam;
    guardianList_ = guardianListParam;
}