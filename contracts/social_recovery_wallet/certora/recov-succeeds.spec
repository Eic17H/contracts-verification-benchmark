// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

// Iterations capped at 64 to avoid stack overflow
/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/recov-succeeds.spec --loop_iter 64 --optimistic_loop

// Batch execution of the test yields FP! for v4 and v10, individual execution yields TN

rule recov_succeeds {

    address newOwner;
    address[] guardianList;
    env e;

    require e.msg.value == 0;

    // modifier onlyInRecovery
    require currentContract.inRecovery;

    // line 112 in v1
    require guardianList.length >= currentContract.threshold;

    // Certora iteration cap
    require guardianList.length < 64;
    
    // lines 115-121 in v1
    require forall uint256 i .
        i < guardianList.length =>
            currentContract.guardianToRecovery[guardianList[i]].recoveryRound == currentContract.currRecoveryRound
        && currentContract.guardianToRecovery[guardianList[i]].proposedOwner == newOwner
        && !currentContract.guardianToRecovery[guardianList[i]].usedInExecuteRecovery
        && to_mathint(guardianList[i]) < 2^160 // cap address value to avoid addresses being rejected
        ;
    
    
    // avoid duplicate guardians
    require forall uint256 i .
        forall uint256 j .
            i < guardianList.length && j < guardianList.length
            && i != j
            => guardianList[i] != guardianList[j]
        ;

    storage initial = lastStorage;
    
    // Find a sender that doesn't make the method revert
    method f;
    calldataarg args;
    require f.selector == sig:supportRecovery(address).selector;
    f@withrevert(e,args);
    require !lastReverted;
    // Whether the sender is a guardian can't be checked directly by reading isGuardian[]
    // because keccak256(abi.encodePacked()) can't be replicated in Certora.


    executeRecovery@withrevert(e, newOwner, guardianList) at initial;

    assert !lastReverted;
    assert currentContract.owner == newOwner;
    assert currentContract._recovered;
}

/* certora.py doesn't allow this, but it would solve the false positive on v14
// If supportRecovery always reverted, the other rule would be satisfied vacuously
rule exists_sender_not_revert {
    env e;
    method f;
    calldataarg args;
    require f.selector == sig:supportRecovery(address).selector;
    f@withrevert(e,args);
    satisfy !lastReverted;
}
//*/