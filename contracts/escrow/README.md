# Escrow

## Specification
This contract involves three participants: a buyer, a seller and an arbiter. At construction, the buyer provides a deposit in ETH, and it specifies the addresses of the seller and of the arbiter, and the fee that will be paid to the arbiter in case it is used to resolve a dispute. After construction, the contract operates in three states: Agree, Dispute, Redeem. 

In the Agree state, one of three things may happen: 
- the buyer approves the payment to the seller (method `approve_payment`); 
- the seller issues a full refund to the buyer (method `refund`);
- either the buyer or the seller open a dispute (method `open_dispute`).

The first two actions transition the state to Redeem, while the latter leads to Dispute.

In the Dispute state, the arbiter redeems the fee, and chooses whom between the buyer and the seller can redeem the residual funds. After the arbiter choice, the state transitions to Redeem. 

In the Redeem state, the chosen recipient can `redeem` the whole contract balance.

## Properties
- **arbitrate-send**: during a successful call to `arbitrate`, the contract sends the arbiter `fee` ETH.
- **auth-in-agree**: in the Agree state, only the buyer and the seller can perform actions.
- **auth-in-dispute**: in the Dispute state, only the arbiter can perform actions.
- **dispute-if-agree**: in the Agree state, both the buyer and the seller can open a dispute.
- **dispute-onlyif-agree**: a dispute can be opened only in the Agree state.
- **no-send-in-agree**: in the Agree state, no one can redeem ETH.
- **recipient-buyer-or-seller**: the recipient of the `redeem` call must be either the buyer or the seller.
- **redeem-send**: after a successful call to `redeem`, either the buyer or the seller receives `deposit` ETH.

## Versions
- **v1**: conformant to specification.
- **v2**: allow arbitrate in any state.
- **v3**: ETH can be redeemed only in the Agree state.
- **v4**: the recipient of the `redeem` call can be anyone.
- **v5**: during a successful call to `arbitrate`, the contract sends the seller `fee` ETH.
- **v6**: in the Dispute state, anyone can perform actions.
- **v7**: a dispute can be opened in any state other than Dispute.
- **v8**: only the arbiter can open disputes in the Agree state.
- **v9**: `redeem` sends the balance to the arbiter, disregarding the `recipient` variable.
- **v10**: conformant to specification, but every time ETH is sent, two calls are used instead of one.
- **v11**: no `deposit` variable.
- **v12**: ETH can be redeemed only in the Agree state, and the recipient may not have been set.
- **v13**: ETH can be redeemed only in the Agree state, and `redeem()` can be called by anyone.
- **v14**: ETH can be redeemed only in the Agree state, the recipient may not have been set, and `redeem()` can be called by anyone.
- **v15**: all methods revert.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|         | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|---------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v10** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v11** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | ERR                       | TP!                       | UNK                       |
| **v12** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       | TN!                       | UNK                       |
| **v13** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v14** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | UNK                       |
| **v15** | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v2** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v3** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v4** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | UNK                       |
| **v5** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v6** | UNK                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v7** | UNK                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TP!                       | UNK                       |
| **v8** | UNK                       | TN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v9** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       | UNK                       |
 

#### Eldarica
|         | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|---------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       |
| **v10** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       |
| **v11** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | ERR                       | UNK                       | TN!                       |
| **v12** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | TN!                       |
| **v13** | TN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TN!                       |
| **v14** | TN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | TN!                       |
| **v15** | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v2** | TN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | UNK                       | TN!                       |
| **v3** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TN!                       |
| **v4** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       |
| **v5** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       |
| **v6** | TN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       |
| **v7** | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | UNK                       | TN!                       |
| **v8** | TN!                       | TN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       |
| **v9** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       | TN!                       |
 

### Certora
|         | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|---------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       |
| **v10** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       |
| **v11** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | ERR                       |
| **v12** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | FP!                       | FP!                       |
| **v13** | FP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | FP!                       |
| **v14** | FP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | FP!                       | FP!                       |
| **v15** | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TP!                       |
| **v2** | FP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | FP!                       |
| **v3** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | FP!                       |
| **v4** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TN                        |
| **v5** | TN                        | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       |
| **v6** | FP!                       | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TP!                       | FP!                       |
| **v7** | FP!                       | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       | FP!                       |
| **v8** | FP!                       | TN                        | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | FP!                       |
| **v9** | FP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TN                        |
 

