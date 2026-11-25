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
expectedBalances[msg.sender] += uint(amount);
expectedBalancesSigned[msg.sender] += int(amount);

/// @custom:preghost function withdraw
expectedBalances[msg.sender] -= uint(amount);
expectedBalancesSigned[msg.sender] -= int(amount);

/// @custom:invariant
function invariant(address a) public {
    checkSigned(balances[a]);
    if(balancesSigned) assert(expectedBalancesSigned[a] == int(balances[a]));
    if(balancesUnsigned) assert(expectedBalances[a] == uint(balances[a]));
}