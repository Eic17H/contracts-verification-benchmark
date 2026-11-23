rule wd_dec_snd_bal {
    env e;
    uint amount;

    mathint currb = nativeBalances[e.msg.sender];
    withdraw(e, amount);
    mathint newb = nativeBalances[e.msg.sender];

    assert(newb == currb - to_mathint(amount));
}
