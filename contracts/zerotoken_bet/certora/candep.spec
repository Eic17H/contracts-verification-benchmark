// before the deadline, if B has at least 1 token and he has not joined the bet yet, 
// then he can deposit 1 token in the contract

rule candep {

    env e;
    mathint old_balance_b = currentContract.balance_b;
    mathint old_balance = currentContract.balance;

    require e.block.number <= currentContract.timeout_block;
    require old_balance_b>=1 && old_balance==1;

    //deposit(e);
    deposit@withrevert(e);

    bool depositReverted = lastReverted;

    mathint new_balance_b = currentContract.balance_b;
    mathint new_balance = currentContract.balance;

    assert !depositReverted => (new_balance_b==old_balance_b-1 && new_balance==2);

}

