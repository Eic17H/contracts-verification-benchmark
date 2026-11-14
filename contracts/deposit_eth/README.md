# Deposit (ETH)

## Specification
The contract accepts a single deposit of ETH through the constructor. The function `withdraw(amount)` can be called by anyone to transfer `amount` ETH to the transaction sender.

## Properties
- **always-depletable**: any user (EOA) at any time can fire a transaction to receive the full balance of the contract.
- **wd-contract-bal**: the contract balance is decreased by `amount` after a successful `withdraw(amount)`.
- **wd-leq-init-bal**: the overall withdrawn amount does not exceed the initial deposit.
- **wd-not-revert**: a transaction `withdraw(amount)` is not reverted whenever the `amount` does not exceed the contract balance.
- **wd-sender-rcv**: after a successful `withdraw(amount)`, the balance of the transaction sender is increased by `amount` ETH.
- **wd-sender-rcv-EOA**: after a successful `withdraw(amount)` originated by an EOA, the balance of the transaction sender is increased by `amount` ETH.

## Versions
- **v1**: reentrant `withdraw`.
- **v2**: non-reentrant `withdraw`.
- **v3**: non-reentrant `withdraw` transfers to `address(0)` instead of `msg.sender`.
- **v4**: non-reentrant `withdraw` transfers `amount-1` instead of `amount` and reverts if the balance isn't at least `amount + 1`.
- **v5**: non-reentrant `withdraw` requires a balance of at least `amount+1` instead of `amount`.
- **v6**: non-reentrant `withdraw`, cannot send funds to owner.
- **v7**: non-reentrant `withdraw`, can only send funds to owner.
- **v8**: `withdraw` callable only by EOAs.
- **v9**: reentrant `withdraw` does not revert.
- **v10**: non-reentrant `withdraw` does not revert.
- **v11**: reentrant `withdraw`, funds are sent to `address(0)` if the first transfer fails.
- **v12**: non-reentrant `withdraw` transfers `amount-1` instead of `amount`.
- **v13**: reentrant `withdraw` transfers `amount-1` instead of `amount`.
- **v14**: reentrant `withdraw` transfers `amount-1` instead of `amount`, except if `amount` is equal to the contract balance.
- **v15**: reentrant `withdraw` transfers `amount-1` instead of `amount`, except if the contract balance is `type(uint256).max`.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|         | always-depletable | wd-contract-bal   | wd-leq-init-bal   | wd-not-revert     | wd-sender-rcv     | wd-sender-rcv-EOA |
|---------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| **v1** | ND                | UNK               | TN!               | ND                | TN!               | FN!               |
| **v10** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v11** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v12** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v13** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v14** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v15** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v2** | ND                | UNK               | TN!               | ND                | TN!               | UNK               |
| **v3** | ND                | UNK               | TN!               | ND                | TN!               | TN!               |
| **v4** | ND                | TN!               | TN!               | ND                | TN!               | TN!               |
| **v5** | ND                | UNK               | TN!               | ND                | TN!               | FN!               |
| **v6** | ND                | UNK               | TN!               | ND                | TN!               | FN!               |
| **v7** | ND                | UNK               | TN!               | ND                | TN!               | FN!               |
| **v8** | ND                | UNK               | TN!               | ND                | FN!               | FN!               |
| **v9** | ND                | ND                | ND                | ND                | ND                | ND                |
 

#### Eldarica
|         | always-depletable | wd-contract-bal   | wd-leq-init-bal   | wd-not-revert     | wd-sender-rcv     | wd-sender-rcv-EOA |
|---------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| **v1** | ND                | TN!               | TN!               | ND                | TN!               | FN!               |
| **v10** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v11** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v12** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v13** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v14** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v15** | ND                | ND                | ND                | ND                | ND                | ND                |
| **v2** | ND                | FP!               | TN!               | ND                | TN!               | FN!               |
| **v3** | ND                | FP!               | TN!               | ND                | TN!               | TN!               |
| **v4** | ND                | TN!               | TN!               | ND                | TN!               | TN!               |
| **v5** | ND                | FP!               | TN!               | ND                | TN!               | FN!               |
| **v6** | ND                | FP!               | TN!               | ND                | TN!               | FN!               |
| **v7** | ND                | FP!               | TN!               | ND                | TN!               | FN!               |
| **v8** | ND                | TN!               | TN!               | ND                | FN!               | FN!               |
| **v9** | ND                | ND                | ND                | ND                | ND                | ND                |
 

### Certora
|         | always-depletable | wd-contract-bal   | wd-leq-init-bal   | wd-not-revert     | wd-sender-rcv     | wd-sender-rcv-EOA |
|---------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| **v1** | TP!               | TN                | TN                | TN                | TN                | TP!               |
| **v10** | FN                | TN                | TN                | FN                | TN                | TN                |
| **v11** | TP!               | ND                | ND                | ND                | ND                | TN                |
| **v12** | TN                | ND                | ND                | ND                | ND                | TN                |
| **v13** | TN                | ND                | ND                | ND                | ND                | TN                |
| **v14** | TP!               | ND                | ND                | ND                | ND                | TN                |
| **v15** | TP!               | ND                | ND                | ND                | ND                | TN                |
| **v2** | FN                | TN                | TN                | TN                | TN                | TP!               |
| **v3** | TN                | ERR               | ERR               | ERR               | ERR               | TN                |
| **v4** | TN                | TN                | TN                | TN                | TN                | TN                |
| **v5** | TN                | TN                | TN                | TN                | TN                | TP!               |
| **v6** | TN                | TN                | TN                | TN                | TN                | TP!               |
| **v7** | TN                | TN                | TN                | TN                | TN                | TP!               |
| **v8** | TP!               | TN                | TN                | FN                | FN                | TP!               |
| **v9** | TP!               | TN                | TN                | FN                | TN                | TN                |
 

