// SPDX-License-Identifier: GPL-3.0-only

// any user (EOA) at any time can fire a transaction to receive the full balance of the contract.

rule always_depletable {
    env e;
    require (e.msg.sender == e.tx.origin);
    uint amount = nativeBalances[currentContract];
    withdraw@withrevert(e, amount);
    
    assert !lastReverted;
    assert (nativeBalances[currentContract] == 0);
}
