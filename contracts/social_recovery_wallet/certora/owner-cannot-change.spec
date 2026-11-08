// the first owner is always the owner, in other words: the owner cannot change (should fail).

/// @custom:run certoraRun versions/SocialRecoveryWallet_v1.sol:Wallet --verify Wallet:certora/owner-cannot-change.spec --optimistic_loop

rule owner_cannot_change {
    env e;
    method f;
    calldataarg args;
    address firstOwner = currentContract._first_owner;
    address oldOwner = currentContract.owner;
    require firstOwner == oldOwner;
    f(e,args);
    address newOwner = currentContract.owner;
    assert firstOwner == newOwner;
}