// the balance of player A is always nonnegative

invariant ab_gte0()
    currentContract.balance_a>=0;
