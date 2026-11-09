// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

// Wrong

/// @custom:negate

/// @custom:ghost
address recov_succeeds_newOwner;

/// @custom:preghost function executeRecovery
require(newOwner == recov_succeeds_newOwner);
require(guardianList.length >= threshold); // line 112 in v1
require(newOwner != owner);
for (uint i = 0; i < guardianList.length; i++) {
    //require(isGuardian[keccak256(abi.encodePacked(guardianList[i]))] == true); // check that the guardian list makes sense
    require(guardianToRecovery[guardianList[i]].recoveryRound == currRecoveryRound); // line 119 in v1
    require(guardianToRecovery[guardianList[i]].proposedOwner == newOwner); // line 120 in v1
    require(!guardianToRecovery[guardianList[i]].usedInExecuteRecovery); // line 121 in v1
    require(guardianList[i] != newOwner); // check the new owner isn't a guardian
}

// check the new owner isn't a guardian
/// @custom:preghost function initiateRecovery
require(msg.sender != recov_succeeds_newOwner);
/// @custom:preghost function supportRecovery
require(msg.sender != recov_succeeds_newOwner);
/// @custom:preghost function executeRecovery
require(msg.sender != recov_succeeds_newOwner);

/// @custom:postghost function executeRecovery
assert(owner != recov_succeeds_newOwner);

/// @custom:invariant
function invariant(address newOwnerParam) public {
    require(newOwnerParam != owner);
    recov_succeeds_newOwner = newOwnerParam;
}