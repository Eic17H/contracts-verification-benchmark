// `executeRecovery()` will fail if not enough guardians have joined the recovery process.

/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/recov-fails.spec --optimistic_loop

rule recov_fails {

    env e;
    require e.msg.value == 0;

    address newOwner;
    address oldOwner = currentContract.owner;
    require newOwner != oldOwner;

    // if not enough guardians have joined the recovery process
    address[] guardianList;
    require guardianList.length < currentContract.threshold;

    // modifier onlyInRecovery
    /* * / require currentContract.inRecovery; //*/

    // then `executeRecovery()` will fail
    executeRecovery@withrevert(e, newOwner, guardianList) /* at initial */;
    // assert lastReverted;
    assert currentContract.owner == oldOwner;
}