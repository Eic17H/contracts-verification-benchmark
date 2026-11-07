// `executeRecovery()` will fail if not enough guardians have joined the recovery process.


rule recov_succeeds {

    address newOwner;
    address oldOwner;
    address[] guardianList;
    env e;

    // line 112 in v1
    require guardianList.length < currentContract.threshold;

    
    require e.msg.value == 0;

    // modifier onlyInRecovery
    require currentContract.inRecovery;


    
    /*

    require guardianList.length < 64;

    // lines 115-121 in v1
    require forall uint256 i .
        i < guardianList.length =>
            currentContract.guardianToRecovery[guardianList[i]].recoveryRound == currentContract.currRecoveryRound
        && currentContract.guardianToRecovery[guardianList[i]].proposedOwner == newOwner
        && !currentContract.guardianToRecovery[guardianList[i]].usedInExecuteRecovery
        && to_mathint(guardianList[i]) < 2^160 // cap address value to avoid addresses being rejected
        ;
    
    storage initial = lastStorage;
    
    // avoid duplicate guardians
    require forall uint256 i .
        forall uint256 j .
            i < guardianList.length && j < guardianList.length
            && i != j
            => guardianList[i] != guardianList[j]
        ;

    // Find a sender that doesn't make the method revert
    method f;
    calldataarg args;
    require f.selector == sig:executeRecovery(address, address[]).selector;
    f@withrevert(e,args);
    require !lastReverted;

    //*/

    oldOwner = currentContract.owner;

    executeRecovery@withrevert(e, newOwner, guardianList) /* at initial */;

    assert lastReverted;
    assert currentContract.owner == oldOwner;
    // assert !currentContract._recovered;
}