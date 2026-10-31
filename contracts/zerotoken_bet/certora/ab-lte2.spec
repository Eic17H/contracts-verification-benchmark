// the balance of player A does not exceed 2 tokens

invariant ab_lte2()
    currentContract.balance_a <= 2;
