// if B has at less than 1 token or he has already joined the bet,
// then he cannot deposit 1 token in the contract

rule cannotdep {
    env e;
    // mathint old_balance = currentContract.balance;    

    mathint old_balance_b_1 = currentContract.balance_b;
    require (old_balance_b_1<1);
    require e.msg.sender == currentContract.b;
    deposit@withrevert(e);
    mathint new_balance_b_1 = currentContract.balance_b;
    assert (lastReverted || old_balance_b_1 == new_balance_b_1);
    
    // mathint new_balance = currentContract.balance;   

    mathint old_balance_b_2 = currentContract.balance_b;
    require (old_balance_b_2<1);
    deposit@withrevert(e);
    mathint new_balance_b_2 = currentContract.balance_b;
    assert (lastReverted || old_balance_b_2 == new_balance_b_2);
}