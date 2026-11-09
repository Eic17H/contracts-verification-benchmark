// SPDX-License-Identifier: GPL-3.0-only

rule wd_contract_bal {
    env e;
    uint amount;
    mathint mi_amount = amount;

    mathint before = nativeBalances[currentContract];
    require before >= mi_amount;
    
    withdraw(e, amount);
    
    mathint after = nativeBalances[currentContract];
    assert before == after + mi_amount;
}
