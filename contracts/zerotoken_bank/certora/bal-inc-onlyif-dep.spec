rule bal_inc_onlyif_dep {
    env e;
    method f;
    calldataarg args;
    address a;

    uint currb = balanceOf(e, a);
    f(e, args);
    uint newb = balanceOf(e, a);

    assert(newb > currb => (f.selector == sig:deposit(uint).selector && e.msg.sender == a));
}
