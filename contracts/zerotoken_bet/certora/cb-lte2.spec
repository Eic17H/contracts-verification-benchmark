// the contract balance does not exceed 2 tokens

invariant cb_lte2()
    currentContract.balance<=2;
