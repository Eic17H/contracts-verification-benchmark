// `contract_balance` is always equal to the sum of the balance entries.

/// @custom:ghost
uint expectedBal;
int expectedBalSigned;
function isSigned(uint n) private pure returns (bool) {return false;}
function isSigned( int n) private pure returns (bool) {return true;}

/// @custom:preghost function deposit
expectedBal -= uint(balances[msg.sender]);
expectedBalSigned -= int(balances[msg.sender]);

/// @custom:postghost function deposit
expectedBal += uint(balances[msg.sender]);
expectedBalSigned += int(balances[msg.sender]);

/// @custom:preghost function withdraw
expectedBal -= uint(balances[msg.sender]);
expectedBalSigned -= int(balances[msg.sender]);

/// @custom:postghost function withdraw
expectedBal += uint(balances[msg.sender]);
expectedBalSigned += int(balances[msg.sender]);

/// @custom:invariant
function invariant() public {
    bool signed = isSigned(balances[msg.sender]);
    bool csigned = isSigned(contract_balance);
    assert(
        ( csigned ||  signed || uint(contract_balance) == expectedBal)
    &&  (!csigned || !signed ||  int(contract_balance) == expectedBalSigned)
    &&  (!csigned ||  signed || expectedBal >= 0 && uint(contract_balance) == uint(expectedBal))
    &&  ( csigned || !signed || expectedBalSigned >= 0 && uint(contract_balance) == uint(expectedBalSigned))
    );
}

