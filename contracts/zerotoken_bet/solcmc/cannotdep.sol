// if B has at less than 1 token or he has already joined the bet,
// then he cannot deposit 1 token in the contract

/// @custom:preghost function deposit
bool pre = balance_b<1;
int old_balance_b = balance_b;

/// @custom:postghost function deposit
assert (!pre || (balance_b==old_balance_b));
// If the requirements for deposit weren't satisfied, then balance_b must not have changed
