invariant cbal_ge_bal (env e, address a)
    totalBalance(e) >= nativeBalances[a];
