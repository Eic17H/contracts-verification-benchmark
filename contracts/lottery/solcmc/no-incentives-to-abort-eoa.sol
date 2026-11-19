// After a non-reverting `reveal0` transaction,
// assuming `player0` and `player1` are EOAs,
// some user can perform, either immediately,
// or in the future provided there are no in-between transactions,
// a transaction that makes `player0` redeem the pot

/// @custom:negate

/// @custom:ghost
bool lastTransactionWasReveal0 = false;
bool assertion = true;

/// @custom:preghost function reveal0
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function reveal0
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = true;


/// @custom:preghost function join0
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function join0
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function join1
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function join1
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem0_nojoin1
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function redeem0_nojoin1
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem1_noreveal0
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function redeem1_noreveal0
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function reveal1
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function reveal1
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function redeem0_noreveal1
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function redeem0_noreveal1
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;


/// @custom:preghost function win
require(player0.code.length == 0);
require(player1.code.length == 0);
uint prebal = player0.balance;

/// @custom:postghost function win
uint postbal = player0.balance;
assertion = (lastTransactionWasReveal0 && postbal-prebal!=2*bet_amount);
lastTransactionWasReveal0 = false;

/// @custom:invariant
function invariant() public {
    assert(assertion);
}