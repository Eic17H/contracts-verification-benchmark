// in the Dispute state, only the arbiter can perform actions.

rule auth_in_dispute {
    env e;
    method f;
    calldataarg args;

    require 
        (  f.selector == sig:approve_payment().selector
        || f.selector == sig:refund().selector
        || f.selector == sig:open_dispute().selector
        || f.selector == sig:arbitrate(address).selector
        || f.selector == sig:redeem().selector);
    
    require(currentContract.state == Escrow.State.DISPUTE);
    f(e, args);
        
    assert (e.msg.sender == currentContract.arbiter);
}
