// in the Agree state, only the buyer and the seller can perform actions.

rule auth_in_agree {
    env e;
    method f;
    calldataarg args;
    
    require(currentContract.state == Escrow.State.AGREE);
    f(e, args);
    assert (e.msg.sender == currentContract.buyer || 
            e.msg.sender == currentContract.seller);
}
