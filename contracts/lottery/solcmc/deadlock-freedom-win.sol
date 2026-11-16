// In state `Win` if contract balance is positive, some user can perform,
// either immediately, or in the future provided there are no in-between
// transactions, a non-reverting transaction that empties the contract balance.

/// @custom:negate

/// @custom:preghost function join0
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function join0
assert(address(this).balance > 0);

/// @custom:preghost function join1
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function join1
assert(address(this).balance > 0);

/// @custom:preghost function redeem0_nojoin1
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function redeem0_nojoin1
assert(address(this).balance > 0);

/// @custom:preghost function reveal0
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function reveal0
assert(address(this).balance > 0);

/// @custom:preghost function redeem1_noreveal0
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function redeem1_noreveal0
assert(address(this).balance > 0);

/// @custom:preghost function reveal1
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function reveal1
assert(address(this).balance > 0);

/// @custom:preghost function redeem0_noreveal1
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function redeem0_noreveal1
assert(address(this).balance > 0);

/// @custom:preghost function win
require(address(this).balance > 0);
require(status == Status.Win);
/// @custom:postghost function win
assert(address(this).balance > 0);