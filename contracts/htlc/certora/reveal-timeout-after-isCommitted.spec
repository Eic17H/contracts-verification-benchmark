// SPDX-License-Identifier: GPL-3.0-only

// A `reveal` or `timeout` transaction won't revert only if contract is in a committed state

rule reveal_timeout_after_isCommitted {
    env e;
    string s;
    method f;

    // Maximum length allowed by the hashing function
    require s.length <= 224;

    require f.selector == sig:reveal(string).selector
         || f.selector == sig:timeout().selector;

    if(f.selector == sig:reveal(string).selector) {
        reveal(e, s);
    } else {
        timeout(e);
    }

    assert currentContract.isCommitted;

}
