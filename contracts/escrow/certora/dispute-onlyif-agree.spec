rule dispute_onlyif_agree {
    env e;

    Escrow.State s = currentContract.state;

    open_dispute@withrevert(e);

    assert(!lastReverted => s == Escrow.State.AGREE);
}