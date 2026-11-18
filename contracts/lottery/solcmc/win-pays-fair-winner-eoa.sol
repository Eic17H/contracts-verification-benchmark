// Assuming `player0` and `player1` are EOAs: in a reachable Win state, a 
// non-reverting `win` transaction must increase by the pot amount the ETH
// balance of the player returned by `compute_winner`

/// @custom:preghost function join0
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);

/// @custom:preghost function join1
require(msg.sender == tx.origin);
require(msg.sender.code.length == 0);

/// @custom:preghost function win
require(status == Status.Win);
require(player0.code.length == 0);
require(player1.code.length == 0);
address payable cwinner = compute_winner(player0, player1, secret0, secret1);
require(cwinner.code.length == 0);
uint prebal = cwinner.balance;
uint pot = address(this).balance;

/// @custom:postghost function win
assert(cwinner.balance - prebal == pot);
