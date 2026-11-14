// SPDX-License-Identifier: GPL-3.0-only

// EOA check
/// @custom:run certoraRun versions/DepositEth_v1.sol:DepositEth --verify DepositEth:certora/wd-sender-rcv-EOA.spec --optimistic_fallback

rule wd_sender_rcv_EOA {
    env e;
    uint amount;

    // EOA check
    require e.msg.sender == e.tx.origin;
    require nativeCodesize[e.msg.sender] == 0;

    address sender = e.msg.sender;

    // If the contract sent itself funds, its balance wouldn't change
    require (sender != currentContract);

    mathint before = nativeBalances[sender];
    withdraw(e, amount);
    mathint after = nativeBalances[sender];

    assert after - before == amount;
}
