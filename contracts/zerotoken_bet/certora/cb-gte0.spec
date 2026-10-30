// the contract balance is always nonnegative

invariant cb_gte0()
    currentContract.balance>=0;

