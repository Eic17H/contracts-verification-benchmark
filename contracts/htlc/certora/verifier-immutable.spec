// SPDX-License-Identifier: GPL-3.0-only

// No succesful transaction can change the address of the verifier

rule verifier_immutable() {
    address _pre_verifier = currentContract.verifier;
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
    assert currentContract.verifier == _pre_verifier,
        "verifier changed after calling function";
}