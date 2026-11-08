// the first owner is always the owner, in other words: the owner cannot change (should fail).

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