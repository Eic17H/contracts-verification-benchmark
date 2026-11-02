// SPDX-License-Identifier: GPL-3.0-only

// If a `reveal` transaction does not revert, `owner`'s balance must increase by at least the balance of the contract

rule reveal_transfer {
    env e;
    string s;
    
    // Maximum length allowed by the hashing function
    require s.length <= 224;

    mathint pre_contract_bal = nativeBalances[currentContract];

    address owner = currentContract.owner;  
    require currentContract != owner;  
    mathint pre_owner_bal = nativeBalances[owner];

    reveal@withrevert(e, s);

    require !lastReverted;
    assert (nativeBalances[owner] >= pre_owner_bal + pre_contract_bal);
}
