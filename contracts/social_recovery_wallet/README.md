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
- **can-change-guardian**: The guardian list can change.
- **can-change-owner**: The owner can change.
- **recov-can-cancel**: A recovery can be canceled.
- **recov-can-happen**: A recovery can happen.
- **recov-requires-guardian**: If an address participates in a recovery, that address is a guardian.
- **recov-succeeds**: If all the right conditions are met for a recovery, the recovery succeeds.
- **recov-threshold**: Recovery fails if the threshold isn't met.
- **removal-can-cancel**: A removal can be canceled.
- **removal-can-happen**: A removal can happen.
- **removal-requires-owner**: Only the owner can remove guardians.

## Versions
- **v1**: conformant to specification, reimplemented independently from v1.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
#### Eldarica
### Certora
