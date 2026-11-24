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

function invariant(address addr) public {
    assert(absv(contract_balance) >= absv(balances[addr]));
    assert(sign(contract_balance) >= sign(balances[addr]));
}
