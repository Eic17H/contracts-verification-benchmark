// the recipient of the `redeem` call must be either the buyer or the seller.

/// @custom:postghost function redeem
assert(recipient == buyer || recipient == seller);
