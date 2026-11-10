// SPDX-License-Identifier: GPL-3.0-only

rule wd_not_revert {
    env e;
    uint amount;
    
    uint before = nativeBalances[currentContract];
    require e.msg.value == 0;
    require amount <= before;
    require e.msg.sender != currentContract;

    withdraw@withrevert(e, amount);
    assert !lastReverted;
}
