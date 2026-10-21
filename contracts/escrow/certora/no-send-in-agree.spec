// in the Agree state, no one can redeem ETH.

rule no_send_in_agree {
    env e;
    method f;
    calldataarg args;

    require(currentContract.state == Escrow.State.AGREE);

    mathint old_balance = nativeBalances[currentContract];        
    f(e, args);
    mathint new_balance = nativeBalances[currentContract];

    assert(old_balance == new_balance);
}