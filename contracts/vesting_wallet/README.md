# Vesting Wallet

## Specification
The contract handles the maturation (vesting) of native cryptocurrency for a given beneficiary. The constructor specifies the address of the beneficiary, the first block height (start) where the beneficiary can withdraw funds, and the overall duration of the vesting scheme. Once the scheme is expired, the beneficiary can withdraw all the funds from the contract. At any moment between the start and the expiration of the vesting scheme, the beneficiary can withdraw an amount of ETH proportional to the time passed since the start of the scheme. The contract can receive ETH at any time through external transactions: these funds will follow the vesting schedule as if they were deposited from the beginning.

## Properties
- **benef-only-recv**: only the beneficiary can receive ETH from the contract
- **exp-all-rel**: if the vesting scheme has expired, then exactly the whole contract balance is releasable.
- **ext-release-rel**: if the beneficiary is an externally owned account, after a successful call to `release`, the beneficiary receives `releasable()` ETH
- **no-start-no-rel**: if the vesting scheme has not started yet, then no balance is releasable.
- **rel-grows-linear**: releasable grows linearly between the start of the vesting scheme and its expiration: two successful consequent calls to `releasable` differ by c*t, where t is the timestamp difference between the two calls, and c is a fixed constant for the contract
- **rel-le-bal**: the amount of releasable ETH is always less than or equal to the contract balance.
- **rel-strict-incr**: before the expiration of the scheme and after the start of the vesting scheme, the releasable amount is strictly increasing whenever the contract balance and the released amount is constant.
- **release-rel**: after a successful call to `release`, the beneficiary receives `releasable()` ETH

## Versions
- **v1**: from [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/finance/VestingWallet.sol).
- **v2**: releasable funds is over-approximated.
- **v3**: balance is releasable even if the vesting scheme hasn't started yet.
- **v4**: after a successful call to `release`, the beneficiary receives half of `releasable()` ETH.
- **v5**: any caller to `release` can receive ETH from the contract.
- **v6**: releasable grows quadratically.
- **v7**: before the expiration of the scheme and after the start of the vesting scheme, the releasable amount is not strictly increasing whenever the contract balance and the released amount is constant.
- **v8**: all methods revert.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|        | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|--------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | UNK              | UNK              | UNK              | UNK              | UNK              | FN               | ND               | UNK              |
| **v2** | UNK              | UNK              | UNK              | TP!              | UNK              | TN               | ND               | UNK              |
| **v3** | UNK              | UNK              | UNK              | UNK              | UNK              | FN               | ND               | UNK              |
| **v4** | UNK              | UNK              | UNK              | UNK              | UNK              | FN               | ND               | UNK              |
| **v5** | UNK              | UNK              | UNK              | TP!              | UNK              | FN               | ND               | UNK              |
| **v6** | UNK              | UNK              | UNK              | TP!              | UNK              | FN               | ND               | UNK              |
| **v7** | UNK              | UNK              | UNK              | TP!              | UNK              | TP!              | ND               | UNK              |
| **v8** | TP!              | FP!              | TP!              | TP!              | TP!              | TP!              | ND               | TP!              |
 

#### Eldarica
|        | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|--------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              |
| **v2** | UNK              | UNK              | UNK              | UNK              | TP!              | UNK              | ND               | UNK              |
| **v3** | UNK              | UNK              | UNK              | UNK              | TP!              | UNK              | ND               | UNK              |
| **v4** | UNK              | UNK              | UNK              | UNK              | TP!              | UNK              | ND               | UNK              |
| **v5** | UNK              | UNK              | UNK              | UNK              | TP!              | UNK              | ND               | UNK              |
| **v6** | UNK              | UNK              | UNK              | UNK              | FP!              | UNK              | ND               | UNK              |
| **v7** | UNK              | UNK              | UNK              | UNK              | FP!              | UNK              | ND               | UNK              |
| **v8** | TP!              | FP!              | TP!              | TP!              | TP!              | TP!              | ND               | TP!              |
 

### Certora
|        | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|--------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | ND               | TP!              | ND               | TP!              | TP!              | TP!              | TP!              | ND               |
| **v2** | ND               | TN               | ND               | TP!              | TP!              | TN               | TP!              | ND               |
| **v3** | ND               | TP!              | ND               | TN               | TP!              | TP!              | TP!              | ND               |
| **v4** | ND               | TP!              | ND               | TP!              | TP!              | TP!              | TP!              | ND               |
| **v5** | ND               | TP!              | ND               | TP!              | TP!              | TP!              | TP!              | ND               |
| **v6** | ND               | TP!              | ND               | TP!              | FP!              | TP!              | FN               | ND               |
| **v7** | ND               | TP!              | ND               | TP!              | FP!              | TP!              | TN               | ND               |
| **v8** | ND               | FP!              | ND               | TP!              | ERR              | TP!              | ERR              | ND               |
 

