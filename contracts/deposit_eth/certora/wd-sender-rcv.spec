// SPDX-License-Identifier: GPL-3.0-only

rule wd_sender_rcv {
    env e;
    uint amount;
    address sender = e.msg.sender;

    mathint before = nativeBalances[sender];
    withdraw(e, amount);
    mathint after = nativeBalances[sender];

    assert after - before == amount;
}
