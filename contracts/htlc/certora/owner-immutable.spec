// SPDX-License-Identifier: GPL-3.0-only

// No succesful transaction can change contract's owner

rule owner_immutable {
    address _pre_owner = currentContract.owner;
    env e;
    calldataarg args;
    method f;
    string s;
    require s.length <= 224;

    if(f.selector == sig:reveal(string).selector) {
        reveal(e, s);
    } else if (f.selector == sig:hashing(string).selector) {
        hashing(e, s);
    } else {
        f(e, args);
    }
    
    assert currentContract.owner == _pre_owner,
        "owner changed after calling function";
}