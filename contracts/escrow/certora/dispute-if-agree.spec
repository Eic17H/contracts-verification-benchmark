// in the Agree state, both the buyer and the seller can open a dispute.

rule dispute_if_agree {
    env e;
    require (currentContract.state == Escrow.State.AGREE);
    require (e.msg.sender == currentContract.buyer || 
             e.msg.sender == currentContract.seller);
    require (e.msg.value == 0);
    
    open_dispute@withrevert(e);

    assert(!lastReverted);
}
