// Assuming `player0` and `player1` behave as EOAs:
// in any reachable `Reveal1` state,
// a user can perform a non-reverting transaction, made after the state's deadline,
// that strictly increases `player0`'s ETH balance by exactly the pot,
// leaves the contract's ETH balance at zero, and advances status to `End`

/// @custom:negate

/// @custom:ghost
bool assertion = false;

/// @custom:preghost function join0
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function join0
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function join1
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function join1
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function redeem0_nojoin1
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function redeem0_nojoin1
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function reveal0
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function reveal0
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function redeem1_noreveal0
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function redeem1_noreveal0
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function reveal1
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function reveal1
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function redeem0_noreveal1
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function redeem0_noreveal1
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:preghost function win
require(msg.sender == tx.origin); // EOA
bool pre = (status == Status.Reveal1 && block.number > end_join);
uint p0_bal_pre = player0.balance;

/// @custom:postghost function win
assertion = (pre && (address(this).balance != 0 || player0.balance < p0_bal_pre || player0.balance - p0_bal_pre != 2*bet_amount || status != Status.End));

/// @custom:invariant
function invariant() public view {
    assert(assertion);
}