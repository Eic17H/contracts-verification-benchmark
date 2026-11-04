// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

rule recov_succeeds {

    address newOwner;
    address[] guardianList;
    env e;

    // TODO: require isGuardian(e.msg.sender)
    // Doesn't work, as Certora can start from a state where guardianList contains addresses that aren't guardians
    require exists uint256 i .
        i < guardianList.length &&
            guardianList[i] == e.msg.sender;

    require currentContract.inRecovery;

    require guardianList.length >= currentContract.threshold;
    
    require forall uint256 i .
        i < guardianList.length =>
            currentContract.guardianToRecovery[guardianList[i]].recoveryRound == currentContract.currRecoveryRound
        && currentContract.guardianToRecovery[guardianList[i]].proposedOwner == newOwner
        && !currentContract.guardianToRecovery[guardianList[i]].usedInExecuteRecovery;

    executeRecovery@withrevert(e, newOwner, guardianList);

    assert !lastReverted;
    assert currentContract.owner == newOwner;
}