// Assuming `player0` and `player1` behave as EOAs:
// in any reachable `Join1` state,
// a user can perform a non-reverting transaction, made after the state's deadline,
// that strictly increases `player0`'s ETH balance by exactly their bet,
// leaves the contract's ETH balance at zero,
// and advances state to `End`

/// @custom:negate

// EOA checks

/// @custom:preghost function join0
require(msg.sender.code.length == 0);
require(msg.sender == tx.origin);

/// @custom:preghost function join1
require(msg.sender.code.length == 0);
require(msg.sender == tx.origin);


/// @custom:ghost
// These act as parameters for the variations of this property
Status immutable targetStartingState = Status.Join1;
uint immutable statusDeadline = end_join;
address payable immutable relevantPlayer = player0;
Status immutable targetFinalState = Status.End;
uint immutable targetPlayerBalanceDiff = bet_amount;
// These store whether the conditions are met
bool correctStartingState = false;
bool afterDeadline = false;
bool strictlyIncreasedBalance = false;
bool emptiedContractBalance = false;
bool correctFinalState = false;
// These are used to know whether the conditions are met
uint oldPlayerBalance = 0;
uint newPlayerBalance = 0;
function isCorrectStartingState() public view returns(bool) {return status == targetStartingState;}
function isAfterDeadline() public view returns(bool) {return block.number > statusDeadline;}
function isEmptyContractBalance() public view returns(bool) {return address(this).balance == 0;}
function isCorrectFinalState() public view returns(bool) {return status == targetFinalState;}
function playerBalance() public view returns(uint) {return relevantPlayer.balance;}
function isCorrectBalanceDiff() public view returns(bool) {return oldPlayerBalance > newPlayerBalance && oldPlayerBalance - newPlayerBalance == targetPlayerBalanceDiff;}
// Final check
bool justExecutedMethod = false;
bool precondition = false;
bool postcondition = false;
function preconditionMet() public view returns(bool) {return correctStartingState && afterDeadline;}
function postconditionMet() public view returns(bool) {return strictlyIncreasedBalance && emptiedContractBalance && correctFinalState;}



/// @custom:preghost function join0
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function join0
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function join1
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function join1
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function redeem0_nojoin1
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function redeem0_nojoin1
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function reveal0
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function reveal0
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function redeem1_noreveal0
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function redeem1_noreveal0
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function reveal1
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function reveal1
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function redeem0_noreveal1
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function redeem0_noreveal1
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:preghost function win
oldPlayerBalance = playerBalance();
correctStartingState = isCorrectStartingState();
afterDeadline = isAfterDeadline();

/// @custom:postghost function win
newPlayerBalance = playerBalance();
strictlyIncreasedBalance = isCorrectBalanceDiff();
emptiedContractBalance = isEmptyContractBalance();
correctFinalState = isCorrectFinalState();
justExecutedMethod = true;
precondition = preconditionMet();
postcondition = postconditionMet();


/// @custom:invariant
function invariant() public {
    if(justExecutedMethod) {
        justExecutedMethod = false;
        assert(!(!precondition || postcondition));
    }
}