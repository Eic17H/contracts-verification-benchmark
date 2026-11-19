// After a non-reverting `redeem0_noreveal1` transaction,
// assuming `player0` and `player1` are EOAs,
// the contract balance is zero

/// @custom:preghost function join0
require(msg.sender == tx.origin);

/// @custom:preghost function join1
require(msg.sender == tx.origin);

/// @custom:preghost function redeem0_noreveal1
require(player0.code.length == 0);
require(player1.code.length == 0);

/// @custom:postghost function redeem0_noreveal1
assert(address(this).balance == 0);
