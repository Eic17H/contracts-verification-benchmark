rule dep_inc_snd_bal {
    env e;
    uint amount;
    
    mathint currb = nativeBalances[e.msg.sender];
    deposit(e, amount);
    mathint newb = nativeBalances[e.msg.sender];

    assert(newb == currb + to_mathint(amount));
}
