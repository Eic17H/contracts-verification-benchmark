// SPDX-License-Identifier: GPL-3.0-only
// TODO fregalo

// TODO: `sent` is private, use hook and persistent ghost variable.

invariant wd_leq_init_bal()
    currentContract.sent <= currentContract.initial_deposit;
