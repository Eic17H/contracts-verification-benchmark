/// @custom:ghost
uint currbu;
int currbi;
uint newbu;
int newbi;

function assignCurr(uint n) public {currbu = n;}
function assignCurr(int n) public {currbi = n;}
function assignNew(uint n) public {newbu = n;}
function assignNew(int n) public {newbi = n;}

function assertion(uint bal, uint amt) public returns (bool) {return newbu - amt == currbu;}
function assertion(int bal, int amt) public returns (bool) {return newbi - amt == currbi;}
function assertion(uint bal, int amt) public returns (bool) {
    if(amt < 0) return newbu == currbu - uint(-amt);
    else return newbu - uint(amt) == currbu;
}
function assertion(int bal, uint amt) public returns (bool) {
    return newbi == currbi + int(amt);
}

/// @custom:preghost function deposit
assignCurr(balances[msg.sender]);

/// @custom:postghost function deposit
assignNew(balances[msg.sender]);
assert(assertion(balances[msg.sender], amount));
