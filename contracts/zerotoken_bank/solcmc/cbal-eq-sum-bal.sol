/// @custom:ghost

function absv(uint n) internal pure returns (uint) {
    return n;
}

function absv(int n) internal pure returns (uint) {
    if(n<0) return uint(-n);
    else return uint(n);
}

function sign(uint n) internal pure returns (uint) {
    return 1;
}

function sign(int n) internal pure returns (uint) {
    if(n<0) return 0;
    else return 1;
}

/// @custom:invariant
function invariant() public {
    uint bals = 0;
    uint160 a;
    // TODO: check if all combinations of signed/unsigned are accounted for
    // TODO: too slow, only check addresses that have been assigned
    for(a = 0; a<type(uint160).max; a++) {
        if(sign(balances[address(a)]) > 0) {
            if(bals > type(uint).max - absv(balances[address(a)])) assert(false);
            bals += absv(balances[address(a)]);
        } else {
            if(bals < absv(balances[address(a)])) assert(false);
            bals -= absv(balances[address(a)]);
        }
    }
    assert(bals == contract_balance);
}