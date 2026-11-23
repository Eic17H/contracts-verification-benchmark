rule dep_inc_snd_bal {
    env e;
    uint amount;
    
    mathint currb = balanceOf(e, e.msg.sender);
    deposit(e, amount);
    mathint newb = balanceOf(e, e.msg.sender);

    assert(newb == currb + to_mathint(amount));
}
