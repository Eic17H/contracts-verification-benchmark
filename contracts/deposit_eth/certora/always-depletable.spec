// SPDX-License-Identifier: GPL-3.0-only

// any user (EOA) at any time can fire a transaction to receive the full balance of the contract.

// Assume recipient of fund transfer is EOA
/// @custom:run certoraRun versions/DepositEth_v1.sol:DepositEth --verify DepositEth:certora/always-depletable.spec --optimistic_fallback

// Non-reentrant versions will revert under the assumption that another reentrant method is in execution and will yield negative.

rule always_depletable() {
    env e;
    require e.msg.sender == e.tx.origin;
    require nativeCodesize[e.msg.sender] == 0;
    require e.msg.value == 0;

    uint contractBalInitial = nativeBalances[currentContract];

    // Avoid overflow revert
    mathint sent = currentContract.sent;
    mathint recBal = nativeBalances[e.msg.sender];

    require sent < 2^256 - contractBalInitial;
    require recBal < 2^256 - contractBalInitial;

    storage initial = lastStorage;

    withdraw@withrevert(e, contractBalInitial) at initial;
    bool rev1 = lastReverted;
    mathint bal1 = nativeBalances[currentContract];
    
    // The require skips the other checks if this one passes
    require bal1 != 0;

    uint diff = assert_uint256(contractBalInitial - bal1);
    uint wdVal2 = assert_uint256(contractBalInitial + bal1);

    require sent < 2^256 - wdVal2;
    require recBal < 2^256 - wdVal2;


    withdraw@withrevert(e, wdVal2) at initial;
    bool rev2 = lastReverted;
    mathint bal2 = nativeBalances[currentContract];

    require bal2 != 0;

    assert false;
}
