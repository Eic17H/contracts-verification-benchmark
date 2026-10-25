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
- **v9**: `releasable` is linear for some values and flat for others.
- **v10**: like v1, but ETH is sent using multiple calls.
- **v11**: releasable grows linearly at 1 ETH/s.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|         | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|---------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              |
| **v10** | ND               | ND               | ND               | ND               | UNK              | ND               | ND               | ND               |
| **v11** | ND               | ND               | ND               | ND               | ND               | ND               | ND               | ND               |
| **v2** | UNK              | UNK              | UNK              | TP!              | UNK              | TN               | ND               | UNK              |
| **v3** | UNK              | UNK              | UNK              | UNK              | UNK              | FN               | ND               | UNK              |
| **v4** | UNK              | UNK              | UNK              | UNK              | UNK              | FN               | ND               | UNK              |
| **v5** | UNK              | UNK              | UNK              | TP!              | UNK              | FN               | ND               | UNK              |
| **v6** | UNK              | UNK              | UNK              | TP!              | UNK              | FN               | ND               | UNK              |
| **v7** | UNK              | UNK              | UNK              | TP!              | UNK              | TP!              | ND               | UNK              |
| **v8** | TP!              | FP!              | TP!              | TP!              | TP!              | TP!              | ND               | TP!              |
| **v9** | ND               | ND               | ND               | ND               | UNK              | ND               | ND               | ND               |
 

#### Eldarica
|         | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|---------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              |
| **v10** | ND               | ND               | ND               | ND               | UNK              | ND               | ND               | ND               |
| **v11** | ND               | ND               | ND               | ND               | ND               | ND               | ND               | ND               |
| **v2** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v3** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v4** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v5** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v6** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v7** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | ND               | UNK              |
| **v8** | TP!              | FP!              | TP!              | TP!              | TP!              | TP!              | ND               | TP!              |
| **v9** | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              | UNK              |
 

### Certora
|         | benef-only-recv  | exp-all-rel      | ext-release-rel  | no-start-no-rel  | rel-grows-linear | rel-le-bal       | rel-strict-incr  | release-rel      |
|---------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|------------------|
| **v1** | TP!              | TP!              | TP!              | TP!              | TP!              | TP!              | TP!              | TP!              |
| **v10** | TP!              | TP!              | FN               | TP!              | TP!              | TP!              | TP!              | FN               |
| **v11** | TP!              | TP!              | TP!              | TP!              | TP!              | TN               | TP!              | TP!              |
| **v2** | TP!              | TN               | TP!              | TP!              | TP!              | TN               | TP!              | TP!              |
| **v3** | TP!              | TP!              | TP!              | TN               | TP!              | TP!              | TP!              | TP!              |
| **v4** | TP!              | TP!              | TN               | TP!              | TP!              | TP!              | TP!              | TN               |
| **v5** | ERR              | TP!              | ERR              | TP!              | ERR              | TP!              | TP!              | ERR              |
| **v6** | TP!              | TP!              | TP!              | TP!              | TN               | TP!              | FN               | TP!              |
| **v7** | TP!              | TP!              | TP!              | TP!              | ERR              | TP!              | TN               | TP!              |
| **v8** | TP!              | FP!              | TP!              | TP!              | ERR              | TP!              | ERR              | TP!              |
| **v9** | TP!              | TP!              | TP!              | TP!              | TN               | TP!              | TN               | TP!              |
 

