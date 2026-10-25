// the amount of releasable tokens is always <= the contract balance

invariant rel_le_bal(env e)
    currentContract.releasable(e) <= nativeBalances[currentContract];
