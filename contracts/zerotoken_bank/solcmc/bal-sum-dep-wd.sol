// for every user `a`,
// their balance entry is equal to the sum of all `amount`s in successful `deposit(amount)` with `msg.sender = a`
// minus those in successful `withdraw(amount)` with `msg.sender = a`.

/// @custom:ghost
mapping(address => uint) expectedBalances;
mapping(address => int) expectedBalancesSigned;
bool balancesSigned;
bool balancesUnsigned;

function checkSigned(int) internal {balancesSigned = true;}
function checkSigned(uint) internal {balancesUnsigned = true;}

/// @custom:preghost function deposit
expectedBalances[msg.sender] += amount;

/// @custom:preghost function withdraw
expectedBalances[msg.sender] -= amount;

/// @custom:invariant
function invariant(address a) public {
    checkSigned(balances[a]);
    if(balancesSigned) assert(balances[a] > 0 && expectedBalances[a] == uint(balances[a])); // todo: balances[a]>0 is wrong
    if(balancesUnsigned) assert(expectedBalances[a] == uint(balances[a]));
}