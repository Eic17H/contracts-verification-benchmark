// the contract balance is unchanged after a call to `callwrap`.

/// @custom:preghost function callwrap
uint _balance = address(this).balance;

/// @custom:postghost function callwrap
assert(_balance == address(this).balance);
