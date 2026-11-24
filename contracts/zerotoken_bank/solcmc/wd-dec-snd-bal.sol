/// @custom:preghost function withdraw
uint currb = balances[msg.sender];

/// @custom:postghost function withdraw
uint newb = balances[msg.sender];
assert(newb == currb - amount);

/// @custom:ghost
uint currbu;
int currbi;
uint newbu;
int newbi;

function assignCurr(uint n) public {currbu = n;}
function assignCurr(int n) public {currbi = n;}
function assignNew(uint n) public {newbu = n;}
function assignNew(int n) public {newbi = n;}

function assertion(uint bal, uint amt) public returns (bool) {return newbu == currbu - amt;}
function assertion(int bal, int amt) public returns (bool) {return newbi == currbi - amt;}
function assertion(uint bal, int amt) public returns (bool) {
    if(amt < 0) return newbu - uint(-amt) == currbu;
    else return newbu == currbu - uint(amt);
}
function assertion(int bal, uint amt) public returns (bool) {
    return newbi + int(amt) == currbi;
}

/// @custom:preghost function withdraw
assignCurr(balances[msg.sender]);

/// @custom:postghost function withdraw
assignNew(balances[msg.sender]);
assert(assertion(balances[msg.sender], amount));
