// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

// Iterations capped at 64 to avoid stack overflow
/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/recov-succeeds.spec --loop_iter 64 --optimistic_loop

rule recov_succeeds {

    address newOwner;
    address[] guardianList;
    env e;
    storage initial = lastStorage;

    require e.msg.value == 0;

    // Find a sender that doesn't make the method revert
    method f;
    calldataarg args;
    require f.selector == sig:executeRecovery(address, address[]).selector;
    f@withrevert(e,args);
    require(!lastReverted);

    // modifier onlyInRecovery
    require currentContract.inRecovery;

    // line 112 in v1
    require guardianList.length >= currentContract.threshold;

    require guardianList.length < 64;
    
    // lines 115-121 in v1
    require forall uint256 i .
        i < guardianList.length =>
            currentContract.guardianToRecovery[guardianList[i]].recoveryRound == currentContract.currRecoveryRound
        && currentContract.guardianToRecovery[guardianList[i]].proposedOwner == newOwner
        && !currentContract.guardianToRecovery[guardianList[i]].usedInExecuteRecovery
        && to_mathint(guardianList[i]) < 2^160 // cap address value to avoid addresses being rejected
        ;
    
    require forall uint256 i .
        forall uint256 j .
            i < guardianList.length && j < guardianList.length
            && i != j
            => guardianList[i] != guardianList[j]
        ;

    executeRecovery@withrevert(e, newOwner, guardianList) at initial;

    assert !lastReverted;
    assert currentContract.owner == newOwner;
    assert currentContract._recovered;
}