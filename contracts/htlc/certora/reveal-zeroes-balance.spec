// SPDX-License-Identifier: GPL-3.0-only

// If a `reveal` transaction does not revert, it must completely drain the contract's balance

rule reveal_zeroes_balance {
    env e;
    string s;

    // Maximum length allowed by the hashing function
    require s.length <= 224;
    
    require currentContract.owner != currentContract;
    require nativeBalances[currentContract] == currentContract.fee;

    reveal@withrevert(e, s);

    require !lastReverted;

    assert nativeBalances[currentContract] == 0;
}