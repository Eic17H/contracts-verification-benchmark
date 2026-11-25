// `contract_balance` is always equal to the sum of the balance entries.

/// @custom:ghost
uint expectedBal;
int expectedBalSigned;
// Overloaded function to know the type of a variable
function isSigned(uint n) private pure returns (bool) {return false;}
function isSigned( int n) private pure returns (bool) {return true;}
bool signed = isSigned(balances[address(0)]);
bool csigned = isSigned(contract_balance);
function absv(uint n) internal pure returns (uint) {
    return n;
}

function absv(int n) internal pure returns (uint) {
    if(n<0) return uint(-n);
    else return uint(n);
}
uint addThis;
uint subThis;

/// @custom:preghost function deposit
if(balances[msg.sender] < 0) addThis = uint(balances[msg.sender]);
else subThis = uint(balances[msg.sender]);

/// @custom:postghost function deposit
if(balances[msg.sender] < 0) subThis += uint(balances[msg.sender]);
else addThis += uint(balances[msg.sender]);
if(csigned) expectedBal = expectedBal + addThis - subThis;
else expectedBalSigned = expectedBalSigned + int(addThis) - int(subThis);

/// @custom:preghost function withdraw
if(balances[msg.sender] < 0) subThis = uint(balances[msg.sender]);
else addThis = uint(balances[msg.sender]);

/// @custom:postghost function withdraw
if(balances[msg.sender] < 0) addThis += uint(balances[msg.sender]);
else subThis += uint(balances[msg.sender]);
if(csigned) expectedBal = expectedBal + addThis - subThis;
else expectedBalSigned = expectedBalSigned + int(addThis) - int(subThis);

/// @custom:invariant
function invariant() public {
    assert(
        !(  csigned /* => */ )|| int(contract_balance) == expectedBalSigned &&
        !( !csigned /* => */ )|| uint(contract_balance) == expectedBal
    );
}

