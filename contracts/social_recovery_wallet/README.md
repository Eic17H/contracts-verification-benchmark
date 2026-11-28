# Social Recovery Wallet
This is a simplified version of
[this](https://github.com/verumlotus/social-recovery-wallet/blob/main/src/Wallet.sol)
contract by [@verumlotus](https://github.com/verumlotus).

The concept was popularized by
[this](https://vitalik.ca/general/2021/01/11/recovery.html) article by Vitalik Buterin.

## Specification
This wallet can be used by the owner to make transactions by calling the
`executeExternalTx()` function, by providing the desired recipient
contract/externally owned account (EOA), an ether value, and arbitrary data.

In case of lost private key, a recovery process can be initiated by a guardian.
The guardian first calls `initiateRecovery()` with the address of the new
owner, followed by a threshold number of guardians calling `supportRecovery()`
with the new owner's address. Finally, any guardian can call
`executeRecovery()` to change the wallet's owner.

Additionally, owners have the ability to manage guardians by removing
compromised or malicious guardians. The owner initiates the removal process by
calling `initiateGuardianRemoval()` with the hash of the guardian's address,
which queues the guardian for removal after a 3-day delay. The owner then calls
`executeGuardianRemoval()` after the delay, providing the hash of a new
guardian's address to finalize the removal and add the new guardian.
Alternatively, the owner can call `cancelGuardianRemoval()` to restore the
guardian state.


## Properties
- **can-change-guardian**: If an address `a` has behaved as a guardian, it might not behave as a guardian now.
- **can-change-guardian-variable**: If an address `a` was in the guardian list, it might not be in the guardian list now.
- **can-change-owner**: If an address `a` has behaved as an owner, it might not behave as an owner now.
- **can-change-owner-variable**: The value of the variable `owner` can change.
- **recov-can-cancel**: If a call to `cancelRecovery()` is followed by `executeRecovery()` with no in-between calls, if an address `a` behaved as the owner before `executeRecovery()` then it must behave as the owner immediately afterwards.
- **recov-can-cancel-variable**: If a call to `cancelRecovery()` is followed by `executeRecovery()` with no in-between calls, the content of the variable `owner` before `executeRecovery()`must be the same as its content immediately afterwards.
- **recov-can-happen**: If `supportRecovery()` was called successfully at least the number of times specified by the `threshold` parameter of the constructor and `cancelRecovery()` wasn't called, then the address that behaves as the owner must be different before and after the call to `executeRecovery()`.
- **recov-can-happen-variable**: If `supportingGuardianCount` for the current round is at least `guardianThreshold` and the contract is in the `inRecovery` state, then the content of the `owner` variable must be different before and after the call to `executeRecovery()`.
- **recov-requires-guardian**: ???
- **recov-requires-guardian-variable**: ???
- **recov-succeeds**: Same as **recov-can-happen**?
- **recov-succeeds-variable**: Same as **recov-can-happen-variable**?
- **recov-threshold**: Reverse **recov-can-happen**?
- **recov-threshold-variable**: Reverse **recov-can-happen-variable**?
- **removal-can-cancel**: Variation of **recov-can-cancel**.
- **removal-can-cancel-variable**: Variation of **recov-can-cancel-variable**.
- **removal-can-happen**: Variation of **recov-can-happen**.
- **removal-can-happen-variable**: Variation of **recov-can-happen-variable**.
- **removal-requires-owner**: Guardian behavior changes if owner behavior.
- **removal-requires-owner-variable**: Guardian list changes if owner variable.

## Versions
- **v1**: conformant to specification.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
#### Eldarica
|        | can-change-guardian     | can-change-owner        | recov-can-cancel        | recov-can-happen        | recov-requires-guardian | recov-succeeds          | recov-threshold         | removal-can-cancel      | removal-can-happen      | removal-requires-owner  |
|--------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------|
| **v1** | UNK                     | UNK                     | ND                      | ND                      | ND                      | ND                      | ND                      | ND                      | ND                      | ND                      |
 

### Certora
