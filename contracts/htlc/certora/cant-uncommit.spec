// SPDX-License-Identifier: GPL-3.0-only

// If contract is in a committed state,
// no transaction should be able to reverse it back to an uncommited state

// Will yield false negatives due to considering input strings too long for the hashing function.

rule cant_uncommit {
    env e;
    require currentContract.isCommitted;
    string s;
    require s.length <= 224;

    method f;
    calldataarg args;

    if(f.selector == sig:reveal(string).selector) {
        reveal(e, s);
    } else if (f.selector == sig:hashing(string).selector) {
        hashing(e, s);
    } else {
        f(e, args);
    }

    assert currentContract.isCommitted;
}
