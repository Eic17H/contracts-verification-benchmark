// SPDX-License-Identifier: GPL-3.0-only

// After a `commit` transaction that does not revert,
// any immediately following `commit` transaction must revert

rule commit_twice_reverts {
    env e;
    bytes32 b1;
    bytes32 b2;
    commit@withrevert(e, b1);
    bool revert1 = lastReverted;
    commit@withrevert(e, b2);
    bool revert2 = lastReverted;
    assert !revert1 => revert2;
}
