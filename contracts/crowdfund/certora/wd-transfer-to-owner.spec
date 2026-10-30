
/// wd-transfer-to-owner:
/// after a non-reverting `withdraw`, the ETH balance of owner is increased by an amount
/// equal to the balance (of Crowdfund) before `withdraw` was called.

// Will fail because of reentrancy, and not because the owner can redirect the funds to a different address as soon as they're received.
// A non-reentrant contract will incorrectly pass the test.

rule wd_transfer_to_owner {
    env e;
    calldataarg args;

    mathint contract_old_balance = nativeBalances[currentContract];
    mathint owner_old_balance = nativeBalances[currentContract.owner];

    withdraw@withrevert(e, args);

    mathint owner_new_balance = nativeBalances[currentContract.owner];

    assert !lastReverted => owner_new_balance - owner_old_balance == contract_old_balance;
}