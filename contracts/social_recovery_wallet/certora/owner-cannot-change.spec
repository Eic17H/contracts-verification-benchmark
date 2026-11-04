// the first owner is always the owner, in other words: the owner cannot change (should fail).

invariant owner_cannot_change()
    currentContract.owner == currentContract._first_owner;