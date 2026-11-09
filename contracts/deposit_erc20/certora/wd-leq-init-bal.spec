// SPDX-License-Identifier: GPL-3.0-only

// TODO: use persistent ghost variable and hook call, `sent` is private.

invariant wd_leq_init_bal()
    currentContract.sent <= currentContract.initial_deposit;
