// Two non-reverting `win` transactions performed from equal contract state
// always yield the same winning player

/// @custom:preghost function win
address payable expectedWinner = compute_winner(player0, player1, secret0, secret1);

/// @custom:postghost function win
assert(winner == expectedWinner);
