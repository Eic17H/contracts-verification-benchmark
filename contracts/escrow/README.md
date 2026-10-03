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
- **v7**: a dispute can be opened in any state.
- **v8**: only the arbiter can open disputes in the Agree state.
- **v9**: after a successful call to `redeem`, the arbiter receives `deposit` ETH.

## Verification data

- [Ground truth](ground-truth.csv)
- [Solcmc/z3](solcmc-z3.csv)
- [Solcmc/Eldarica](solcmc-eld.csv)
- [Certora](certora.csv)

## Experiments
### SolCMC
#### Z3
|        | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|--------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | UNK                       | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v2** | UNK                       | TN!                       | TP!                       | FN!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v3** | UNK                       | FN!                       | TP!                       | FN!                       | TP!                       | UNK                       | FN!                       | TP!                       |
| **v4** | UNK                       | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TN!                       | UNK                       |
| **v5** | UNK                       | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v6** | UNK                       | TP!                       | TN!                       | FN!                       | TP!                       | TP!                       | FN!                       | UNK                       |
| **v7** | UNK                       | TP!                       | UNK                       | FN!                       | TN!                       | TP!                       | TP!                       | UNK                       |
| **v8** | UNK                       | FN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v9** | UNK                       | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | UNK                       |
 

#### Eldarica
|        | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|--------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | FN                        | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v2** | UNK                       | TN!                       | TP!                       | FN!                       | TP!                       | TN!                       | UNK                       | FN!                       |
| **v3** | TP!                       | FN!                       | TP!                       | FN!                       | TP!                       | FP!                       | FN!                       | TP!                       |
| **v4** | FN                        | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TN!                       | FN!                       |
| **v5** | UNK                       | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v6** | FN                        | TP!                       | TN!                       | FN!                       | TP!                       | TP!                       | FN!                       | FN!                       |
| **v7** | UNK                       | TP!                       | FN!                       | FN!                       | TN!                       | TP!                       | UNK                       | FN!                       |
| **v8** | FN                        | FN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v9** | FN                        | TP!                       | TP!                       | FN!                       | TP!                       | TP!                       | TP!                       | TN!                       |
 


### Certora
|        | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|--------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v2** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v3** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v4** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v5** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v6** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v7** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v8** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
| **v9** | ND                        | ND                        | ND                        | ND                        | ND                        | ERR                       | ND                        | ND                        |
 

