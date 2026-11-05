// if a number of guardians greater than or equal to the threshold
// have participated in the same recovery round, and selected the same new owner,
// then `executeRecovery()` will succeed and `owner == newOwner`.

// Iterations capped at 64 to avoid stack overflow
/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/recov-succeeds.spec --loop_iter 64

rule recov_succeeds {

    address newOwner;
    address[] guardianList;
    env e;

    require e.msg.value == 0;

    // modifier onlyGuardian
    // Still doesn't work because packedSender is turned back into a bytes32 when hashed
    bytes20 packedSender;
    require packedSender == to_bytes20(assert_uint160(to_mathint(e.msg.sender)));
    require currentContract.isGuardian[keccak256(packedSender)];

    // modifier onlyInRecovery
    require currentContract.inRecovery;

    // line 112 in v1
    require guardianList.length >= currentContract.threshold;

    require guardianList.length <= 64;
    
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

    executeRecovery@withrevert(e, newOwner, guardianList);

    assert !lastReverted;
    assert currentContract.owner == newOwner;
    assert currentContract._recovered;
}