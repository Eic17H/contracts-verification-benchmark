// SPDX-License-Identifier: GPL-3.0-only

// If a `reveal(s)` transaction does not revert, then `s` is a preimage of the committed hash

rule wrong_preimage_reverts {
    env e;
    string s;
    // Maximum length allowed by the hashing function
    require s.length <= 224;
    require hashing(e, s) != currentContract.hash;
    reveal@withrevert(e, s);
    assert lastReverted;
}