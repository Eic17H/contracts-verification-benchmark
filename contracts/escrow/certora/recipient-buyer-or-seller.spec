// the recipient of the `redeem` call must be either the buyer or the seller.

ghost bool correctRecipient { init_state axiom correctRecipient == false; }
ghost address recipient { init_state axiom recipient == 0x0; }
hook CALL(uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    correctRecipient = (addr == currentContract.buyer || addr == currentContract.seller);
    recipient = addr;
}

// FP in v12 and v14 because a call to an unassigned `recipient` seems to revert


rule recipient_buyer_or_seller {
    env e;
    method f;
    calldataarg args;

    // Calling a different method first, to ensure that redeem() is called in a state where it can be called
    require f.selector != sig:redeem().selector;
    f(e,args);

    redeem(e);
    assert correctRecipient;
    assert recipient == currentContract.buyer || recipient == currentContract.seller;
}
