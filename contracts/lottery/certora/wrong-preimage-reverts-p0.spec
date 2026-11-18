// SPDX-License-Identifier: GPL-3.0-only

// If a `reveal0(s)` transaction does not revert, then `s` is a preimage of the
// hash committed by `player0`

/// @custom:run certoraRun versions/Lottery_v1.sol:Lottery --verify Lottery:certora/wrong-preimage-reverts-p0.spec --optimistic_hashing
rule wrong_preimage_reverts_p0 {
    env novalue;
    env yesvalue;
    bytes32 committed_hash;
    bytes32 secret_hash;
    string secret;

    require novalue.msg.value == 0;
    require yesvalue.msg.sender == currentContract.player0;
    require currentContract.status == Lottery.Status.Reveal0;
    committed_hash = currentContract.hash0;

    // Calling hashing with msg.value>0 would make it revert,
    // implicitly forcing reveal0 to be called with msg.value==0,
    // but v33 violates the property when msg.value>0.

    secret_hash = hashing(novalue, secret);

    require secret_hash != committed_hash;

    reveal0@withrevert(yesvalue, secret);

    assert lastReverted;
}
