// SPDX-License-Identifier: GPL-3.0-only

// any user (EOA) at any time can fire a transaction to receive the full balance of the contract.

rule always_depletable {
    env e;
    require e.msg.sender == e.tx.origin; // Certora still assumes the sender can reject the payment
    
    uint bal = nativeBalances[currentContract];
    storage initial = lastStorage;

    uint x = bal;
    uint bal1;
    uint bal2;
    uint bal3;

    withdraw@withrevert(e,x) at initial;
    bool rev1 = lastReverted;
    bal1 = nativeBalances[currentContract];

    if(bal1 != 0){

    require x+bal1 < 2^256;
    uint x1 = assert_uint256(x+bal1);


    withdraw@withrevert(e,x1) at initial;
    bool rev2 = lastReverted;
    bal2 = nativeBalances[currentContract];

    if(bal2 != 0){

    require x1+bal2 < 2^256;
    uint x2 = assert_uint256(x1+bal2);

    withdraw@withrevert(e,x2) at initial;
    bool rev3 = lastReverted;
    bal3 = nativeBalances[currentContract];} else bal3 = 0;} else {bal2 = 0; bal3 = 0;}

    assert bal1==0 || bal2==0 || bal3==0;
}
