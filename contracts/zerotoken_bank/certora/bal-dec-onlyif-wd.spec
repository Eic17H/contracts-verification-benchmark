rule bal_dec_onlyif_wd {
    env e;
    method f;
    calldataarg args;
    address a;

    uint currb = nativeBalances[a];
    f(e, args);
    uint newb = nativeBalances[a];

    assert(newb < currb => (f.selector == sig:withdraw(uint).selector && e.msg.sender == a));
}
