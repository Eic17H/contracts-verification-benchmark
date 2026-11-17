/*
    Assuming `player0` and `player1` are EOAs:
    in any state where the winner is not yet determined,
    for every transaction whose sender is neither `player0` nor `player1`;
    if such transaction changes the contract storage,
    then the same transaction (except for `msg.sender`), made by any EOA, in the same state,
    must produce the same state modifications.
*/

/// @custom:nondef Cannot compare behavior of different senders.