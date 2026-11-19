// After a non-reverting `reveal0` transaction,
// assuming `player0` and `player1` are EOAs,
// some user can perform, either immediately,
// or in the future provided there are no in-between transactions,
// a `redeem0_noreveal1` transaction that makes `player0` redeem the pot

/// @custom:negate

/// @custom:ghost
bool lastTransactionWasReveal0 = false;

/// @custom:preghost function reveal0
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function reveal0
lastTransactionWasReveal0 = true;


/// @custom:preghost function join0
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);

/// @custom:postghost function join0
lastTransactionWasReveal0 = false;


/// @custom:preghost function join1
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);

/// @custom:postghost function join1
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem0_nojoin1
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function redeem0_nojoin1
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem1_noreveal0
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function redeem1_noreveal0
lastTransactionWasReveal0 = false;


/// @custom:preghost function reveal1
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function reveal1
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem0_noreveal1
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function redeem0_noreveal1
uint postbal = player0.balance;
assert(lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function win
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function win
lastTransactionWasReveal0 = false;
