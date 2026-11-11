# Call Wrapper

## Specification
The contract acts as a wrapper to Solidity's `call` function.

## Properties
- **bal**: the contract balance is unchanged after a call to `callwrap`.
- **stor**: the contract storage is unchanged after a call to `callwrap`.

## Versions
- **v1**: reentrant `callwrap`.
- **v2**: non-reentrant `callwrap`.
- **v3**: reentrant `callwrap` and additional reentrant function `modifystorage`.
- **v4**: non-reentrant `callwrap` and additional reentrant function `modifystorage`.
- **v5**: non-reentrant `callwrap` and additional non-reentrant function `modifystorage`.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|        | bal   | stor  |
|--------|-------|-------|
| **v1** | TN!   | TP!   |
| **v2** | FP!   | TP!   |
| **v3** | TN!   | TN!   |
| **v4** | TN!   | TN!   |
| **v5** | FP!   | TP!   |
 

#### Eldarica
|        | bal   | stor  |
|--------|-------|-------|
| **v1** | TN!   | TP!   |
| **v2** | FP!   | TP!   |
| **v3** | TN!   | TN!   |
| **v4** | TN!   | TN!   |
| **v5** | FP!   | TP!   |
 

### Certora
|        | bal   | stor  |
|--------|-------|-------|
| **v1** | TN    | TP!   |
| **v2** | TN    | TP!   |
| **v3** | TN    | FP!   |
| **v4** | TN    | FP!   |
| **v5** | TN    | TP!   |
 

