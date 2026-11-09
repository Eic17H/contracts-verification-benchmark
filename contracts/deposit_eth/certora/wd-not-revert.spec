// SPDX-License-Identifier: GPL-3.0-only

rule wd_not_revert {
    env e;
    uint amount;
    
    uint before = nativeBalances[currentContract];
    require e.msg.value == 0;
    require amount <= before;

    withdraw@withrevert(e, amount);
    assert !lastReverted;
}
