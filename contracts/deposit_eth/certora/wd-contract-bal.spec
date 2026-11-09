// SPDX-License-Identifier: GPL-3.0-only

rule wd_contract_bal {
    env e;
    uint amount;
    mathint before = nativeBalances[currentContract];
    withdraw(e, amount);
    
    mathint after = nativeBalances[currentContract];
    assert before == after + amount;
}
