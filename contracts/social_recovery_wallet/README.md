# Social Recovery Wallet
This is a simplified version of
[this](https://github.com/verumlotus/social-recovery-wallet/blob/main/src/Wallet.sol)
contract by [@verumlotus](https://github.com/verumlotus).

The concept was popularized by
[this](https://vitalik.ca/general/2021/01/11/recovery.html) article by Vitalik Buterin.

## Specification
This wallet can be used by the owner to make transactions by calling `the
executeExternalTx()` function, by provinding the desired recipient
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
- **no-recov**: the recovery can never happen (should fail).
- **owner-cannot-change**: the first owner is always the owner, in other words: the owner cannot change (should fail).
- **recov-fails**: `executeRecovery()` will fail if not enough guardians have joined the recovery process.
- **recov-implies-guardian**: if an address `addr` has participated in a recovery, then `addr` is a guardian. Should fail in v1 because guardians can be removed.
- **recov-succeeds**: if a number of guardians greater than or equal to the threshold have participated in the same recovery round, and selected the same new owner, then `executeRecovery()` will succeed and `owner == newOwner`.

## Versions
- **v1**: conformant to specification.
- **v2**: removed guardian management.
- **v3**: owner cannot be changed.
- **v4**: recovery changes the owner to the guardian that initiated the recovery process.
- **v5**: if the current owner isn't the first owner, recovery changes the owner to the first owner.
- **v6**: any address is treated as a guardian.
- **v7**: any address is treated as the owner.
- **v8**: the owner is always considered a guardian.
- **v9**: after recovery, the old owner replaces the guardian that initiated the recovery.
- **v10**: after recovery, the guardian that initiated the recovery becomes the owner, and the proposed owner becomes a guardian.
- **v11**: the threshold of guardians that need to support the recovery is always 0.
- **v12**: the number of guardians supporting the recovery has an upper limit equal to double the lower threshold.
- **v13**: the threshold of guardians supporting the recovery is treated as an upper bound instead of a lower bound.
- **v14**: recovery always reverts.
- **v15**: all methods always revert.
- **v16**: all methods do nothing.
- **v17**: all methods do nothing, but revert when they're supposed to.
- **v18**: `executeExternalTx` is reentrant.
- **v19**: the threshold of guardians that need to support the recovery isn't checked.
- **v20**: methods don't revert.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|         | no-recov               | owner-cannot-change    | recov-fails            | recov-implies-guardian | recov-succeeds         |
|---------|------------------------|------------------------|------------------------|------------------------|------------------------|
| **v1** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v10** | UNK                    | UNK                    | ERR                    | TN!                    | ERR                    |
| **v11** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v12** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v13** | UNK                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v14** | TP!                    | TP!                    | ERR                    | FN!                    | ERR                    |
| **v15** | TP!                    | TP!                    | ERR                    | TP!                    | ERR                    |
| **v16** | TP!                    | TP!                    | ERR                    | TP!                    | ERR                    |
| **v17** | TP!                    | TP!                    | ERR                    | TP!                    | ERR                    |
| **v18** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v19** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v2** | TN!                    | TN!                    | ERR                    | UNK                    | ERR                    |
| **v20** | TN!                    | TN!                    | ERR                    | TN!                    | ERR                    |
| **v3** | TN!                    | TP!                    | ERR                    | UNK                    | ERR                    |
| **v4** | UNK                    | TN!                    | ERR                    | TN!                    | ERR                    |
| **v5** | UNK                    | TN!                    | ERR                    | UNK                    | ERR                    |
| **v6** | TN!                    | UNK                    | ERR                    | TN!                    | ERR                    |
| **v7** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v8** | UNK                    | UNK                    | ERR                    | UNK                    | ERR                    |
| **v9** | TN!                    | UNK                    | ERR                    | UNK                    | ERR                    |
 

#### Eldarica
|         | no-recov               | owner-cannot-change    | recov-fails            | recov-implies-guardian | recov-succeeds         |
|---------|------------------------|------------------------|------------------------|------------------------|------------------------|
| **v1** | TN!                    | TN!                    | TP!                    | TN!                    | TP!                    |
| **v10** | TN!                    | TN!                    | TP!                    | TN!                    | FP!                    |
| **v11** | TN!                    | TN!                    | FP!                    | TN!                    | TP!                    |
| **v12** | TN!                    | TN!                    | TP!                    | TN!                    | FP!                    |
| **v13** | TN!                    | TN!                    | TN!                    | TN!                    | FP!                    |
| **v14** | TP!                    | TP!                    | TP!                    | FN!                    | TN!                    |
| **v15** | TP!                    | TP!                    | TP!                    | TP!                    | FN!                    |
| **v16** | TP!                    | TP!                    | TP!                    | TP!                    | TN!                    |
| **v17** | TP!                    | TP!                    | TP!                    | TP!                    | TN!                    |
| **v18** | TN!                    | TN!                    | TP!                    | TN                     | TP!                    |
| **v19** | TN!                    | TN!                    | TN!                    | TN!                    | TP!                    |
| **v2** | TN!                    | TN!                    | TP!                    | FN                     | TP!                    |
| **v20** | TN!                    | TN!                    | TN!                    | TN!                    | TP!                    |
| **v3** | TN!                    | UNK                    | TP!                    | TN!                    | TP!                    |
| **v4** | TN!                    | TN!                    | TP!                    | TN                     | FP!                    |
| **v5** | TN!                    | TN!                    | TP!                    | TN                     | FP!                    |
| **v6** | TN!                    | TN!                    | TP!                    | TN!                    | TP!                    |
| **v7** | TN!                    | TN!                    | TP!                    | TN!                    | TP!                    |
| **v8** | TN                     | UNK                    | TP!                    | UNK                    | TP!                    |
| **v9** | TN                     | UNK                    | TP!                    | TN                     | TP!                    |
 

### Certora
|         | no-recov               | owner-cannot-change    | recov-fails            | recov-implies-guardian | recov-succeeds         |
|---------|------------------------|------------------------|------------------------|------------------------|------------------------|
| **v1** | TN                     | TN                     | ND                     | ERR                    | FN                     |
| **v10** | TN                     | TN                     | ND                     | ND                     | TN                     |
| **v11** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v12** | TN                     | TN                     | ND                     | ND                     | TN                     |
| **v13** | TN                     | TN                     | ND                     | ND                     | TN                     |
| **v14** | TP!                    | FN                     | ND                     | ND                     | TN                     |
| **v15** | TP!                    | FN                     | ND                     | ND                     | FN                     |
| **v16** | FN                     | FN                     | ND                     | ND                     | TN                     |
| **v17** | FN                     | FN                     | ND                     | ND                     | TN                     |
| **v18** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v19** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v2** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v20** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v3** | TN                     | FN                     | ND                     | ND                     | FN                     |
| **v4** | TN                     | TN                     | ND                     | ND                     | TN                     |
| **v5** | TN                     | TN                     | ND                     | ND                     | TN                     |
| **v6** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v7** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v8** | TN                     | TN                     | ND                     | ND                     | FN                     |
| **v9** | TN                     | TN                     | ND                     | ND                     | FN                     |
 

