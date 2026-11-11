// the contract storage is unchanged after a call to `callwrap`.

/// @custom:preghost function callwrap
uint _data = data;

/// @custom:postghost function callwrap
assert(_data == data);
