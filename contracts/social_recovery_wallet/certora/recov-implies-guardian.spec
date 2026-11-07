// 

// Iterations capped at 64 to avoid stack overflow
/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/recov-succeeds.spec --loop_iter 64 --optimistic_loop

rule recov_implies_guardian {

    address newOwner;
    address[] guardianList;
    env e;

    require e.msg.value == 0;

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
    
    // storage initial = lastStorage;
    
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
    // All other preconditions are met, so a non-guardian sender is the only way for the method to revert
    bool senderIsGuardian = !lastReverted;

    

            assert guardianToRecovery[msg.sender].proposedOwner != address(0) => senderIsGuardian;
}