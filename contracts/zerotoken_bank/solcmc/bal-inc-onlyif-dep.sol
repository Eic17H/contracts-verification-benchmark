/// @custom:ghost
bool inc = false;
uint preu;
int prei;
function assignPre(uint n) public {preu = n;}
function assignPre(int n) public {prei = n;}
function compare(uint n) public returns (bool) {return n > preu;}
function compare(int n) public returns (bool) {return n > prei;}

/// @custom:preghost function withdraw
assignPre(balances[msg.sender]);

/// @custom:postghost function withdraw
inc = compare(balances[msg.sender]);

/// @custom:invariant
function invariant() public {
    assert(!inc);
}