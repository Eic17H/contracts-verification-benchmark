// SPDX-License-Identifier: GPL-3.0-only

rule always_depletable {
    env e;
    require (e.msg.sender == e.tx.origin);
    uint amount = nativeBalances[currentContract];
    withdraw@withrevert(e, amount);
    
    assert !lastReverted;
    assert (nativeBalances[currentContract] == 0);
}
