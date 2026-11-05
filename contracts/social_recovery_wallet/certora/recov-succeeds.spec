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
    require currentContract.isGuardian[
        keccak256( // hash
            to_bytes20( // 20 byte array (equivalent to abi.encodePacked())
                assert_uint160( // 20 byte uint
                    assert_uint256( // 32 byte uint
                        to_bytes32( // 32 byte array
                            e.msg.sender
                        )
                    )
                )
            )
        )
    ];

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
        // && guardianList[i] < address(2^160) // cap address value to avoid addresses being rejected, I don't know how to do it
        ;

    executeRecovery@withrevert(e, newOwner, guardianList);

    assert !lastReverted;
    assert currentContract.owner == newOwner;
    assert currentContract._recovered;
}