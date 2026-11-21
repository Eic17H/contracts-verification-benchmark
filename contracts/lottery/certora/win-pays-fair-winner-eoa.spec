// SPDX-License-Identifier: GPL-3.0-only

// Assuming `player0` and `player1` are EOAs: in a reachable Win state, a 
// non-reverting `win` transaction must increase by the pot amount the ETH
// balance of the player returned by `compute_winner`

/// @custom:run certoraRun versions/Lottery_v1.sol:Lottery versions/lib/EOA0.sol versions/lib/EOA1.sol --verify Lottery:certora/win-pays-fair-winner-eoa.spec --link Lottery:player0=EOA0 --link Lottery:player1=EOA1 --optimistic_hashing --optimistic_loop
rule win_pays_fair_winner_eoa {
    env e;
    require currentContract.status == Lottery.Status.Win;

    address p0 = currentContract.player0;
    address p1 = currentContract.player1;
    require p0 != currentContract;
    require p1 != currentContract;
    require p0 != p1;

    address expected_winner = compute_winner(e, p0, p1, secret0(e), secret1(e));
    mathint pre_bal = nativeBalances[expected_winner];
    mathint pre_pot = nativeBalances[currentContract];

    win(e);

    mathint post_bal = nativeBalances[expected_winner];
    mathint post_pot = nativeBalances[currentContract];

    // Certora may start from an unreachable state, such as one where the bet is more than the contract balance in the Win state
    // That is impossible in v1, but requiring the bet to be equal to the contract balance would rule out versions that incorrectly compute the bet amount
    mathint bet = currentContract.bet_amount;

    assert (post_bal - pre_bal == pre_pot && post_pot == 0);
}
