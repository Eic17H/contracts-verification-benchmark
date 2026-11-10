// SPDX-License-Identifier: GPL-3.0-only

rule wd_sender_rcv_EOA {
    env e;
    uint amount;
    address sender = e.msg.sender;

    require (sender == e.tx.origin);

    // If the contract sent itself funds, its balance wouldn't change
    require (sender != currentContract);

    mathint before = nativeBalances[sender];
    withdraw(e, amount);
    mathint after = nativeBalances[sender];

    assert after - before == amount;
}
