// The contract's balance should only increase if the `commit()` function is called

// Will fail because the balance can be forcibly increased by a `selfdestruct`.

/// @custom:ghost
uint256 _preBal;
uint256 _postBal;

/// @custom:preghost function commit
_preBal = address(this).balance - msg.value;

/// @custom:preghost function reveal
_preBal = address(this).balance;

/// @custom:preghost function timeout
_preBal = address(this).balance;

/// @custom:postghost function commit
_postBal = address(this).balance;

/// @custom:postghost function reveal
_postBal = address(this).balance;
assert (!(_postBal > _preBal));

/// @custom:postghost function timeout
_postBal = address(this).balance;
assert (!(_postBal > _preBal));