# Deposit (ERC20)

## Specification
This contract implements the same functionality of the [Deposit contract](../deposit_eth), but operates on ERC20 tokens instead of ETH. 

The `constructor` takes the token address as a parameter. 

The `deposit` function allows the sender to deposit an arbitrary number of token units into the contract; it can be called only once. Before calling `deposit`, the depositor must approve that the amount they want to deposit can be spent by the contract: if so, the entire allowance is transferred to the contract.

The function `withdraw(amount)` can be called by anyone to transfer `amount` token units to the transaction sender.

## Properties
- **no-deposit-twice**: `deposit` can only be called once.
- **wd-contract-bal**: the contract token balance is decreased by `amount` after a successful `withdraw(amount)`.
- **wd-leq-init-bal**: the overall withdrawn amount does not exceed the initial deposit.

## Versions
- **v1**: conformant to specification.
- **v2**: safe IERC20 interactions by using [SafeERC20.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol) (OpenZeppelin)
- **v3**: methods are non reentrant.
- **v4**: `deposit` always reverts.
- **v5**: can deposit exactly twice.
- **v6**: can deposit multiple times.
- **v7**: `withdraw` always reverts.
- **v8**: can only withdraw once.
- **v9**: all methods always revert.
- **v10**: all methods do nothing.
- **v11**: all methods do nothing, but revert when they should.
- **v12**: only the depositor can withdraw.
- **v13**: depositor can't withdraw.
- **v14**: withdraw withholds one token.
- **v15**: each address can only withdraw once.
- **v16**: `withdraw` always sends funds to depositor.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|        | no-deposit-twice | wd-contract-bal  | wd-leq-init-bal  |
|--------|------------------|------------------|------------------|
| **v1** | TP!              | FN!              | TN!              |
| **v2** | TP!              | FN!              | UNK              |
 

#### Eldarica
|        | no-deposit-twice | wd-contract-bal  | wd-leq-init-bal  |
|--------|------------------|------------------|------------------|
| **v1** | TP!              | FN!              | TN!              |
| **v2** | TP!              | FN!              | TN!              |
 

### Certora
|        | no-deposit-twice | wd-contract-bal  | wd-leq-init-bal  |
|--------|------------------|------------------|------------------|
| **v1** | TP!              | FN               | TN               |
| **v2** | TP!              | FN               | TN               |
 

