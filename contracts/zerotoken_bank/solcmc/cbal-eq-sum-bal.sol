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
uint toAdd;
uint toSub;
bool doesOverflow;
bool doesUnderflow;
function addsub(uint add1, uint add2, uint sub1, uint sub2) internal pure returns (uint add, uint sub, bool overflow, bool underflow) {
    uint addp1;
    uint subp1;
    uint addp2;
    uint subp2;

    if(add1>sub1) addp1 = add1-sub1;
    else subp1 = sub1-add1;

    if(add2>sub2) addp2 = add2-sub2;
    else subp2 = sub2-add2;

    if(addp1>0 && addp2>0) {
        if(addp1 > type(uint).max-addp2) overflow = true;
        else add = addp1 + addp2;
    } else if(subp1>0 && subp2>0) {
        if(subp1 > type(uint).max-subp2) underflow = true;
        else sub = subp1 + subp2;
    } else if(addp1>0 && subp2>0) {
        if(addp1>subp2) add = addp1-subp2;
        else sub = subp2-addp1;
    } else if(addp2>0 && subp1>0) {
        if(addp2>subp1) add = addp2-subp1;
        else sub = subp1-addp2;
    } else {
        add = addp1+addp2;
        sub = subp1+subp2;
    }
}

/// @custom:preghost function deposit
if(balances[msg.sender] < 0) add1 = uint(balances[msg.sender]);
else sub1 = uint(balances[msg.sender]);

/// @custom:postghost function deposit
if(balances[msg.sender] < 0) sub2 = uint(balances[msg.sender]);
else add2 = uint(balances[msg.sender]);
(toAdd, toSub, doesOverflow, doesUnderflow) = addsub(add1, add2, sub1, sub2);
if(!doesUnderflow && !doesOverflow){
    if(csigned) expectedBal = expectedBal + toAdd - toSub;
    else expectedBalSigned = expectedBalSigned + int(toAdd) - int(toSub);
}


/// @custom:preghost function withdraw
if(balances[msg.sender] < 0) sub1 = uint(balances[msg.sender]);
else add1 = uint(balances[msg.sender]);

/// @custom:postghost function withdraw
if(balances[msg.sender] < 0) add2 = uint(balances[msg.sender]);
else sub2 = uint(balances[msg.sender]);
(toAdd, toSub, doesOverflow, doesUnderflow) = addsub(add1, add2, sub1, sub2);
if(!doesUnderflow && !doesOverflow){
    if(csigned) expectedBal = expectedBal + toAdd - toSub;
    else expectedBalSigned = expectedBalSigned + int(toAdd) - int(toSub);
}

/// @custom:invariant
function invariant() public {
    assert(
        !(  csigned /* => */ )|| int(contract_balance) == expectedBalSigned &&
        !( !csigned /* => */ )|| uint(contract_balance) == expectedBal &&
        !doesOverflow;
        !doesUnderflow;
    );
}

