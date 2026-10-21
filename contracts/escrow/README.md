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
- **v9**: after a successful call to `redeem`, the arbiter receives `deposit` ETH.
- **v10**: conformant to specification, but very time ETH is sent, two calls are used instead of one.
- **v11**: no `deposit` variable.
- **v12**: ETH can be redeemed only in the Agree state.
- **v13**: ETH can be redeemed only in the Agree state.
- **v14**: ETH can be redeemed only in the Agree state.

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
| **v12** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | UNK                       |
| **v13** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v14** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | UNK                       |
| **v2** | UNK                       | TN!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v3** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       | TP!                       | UNK                       |
| **v4** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | UNK                       |
| **v5** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v6** | UNK                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v7** | UNK                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TP!                       | UNK                       |
| **v8** | UNK                       | TN!                       | TP!                       | FP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
| **v9** | UNK                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | UNK                       |
 

#### Eldarica
|         | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|---------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | FN!                       | TP!                       | TP!                       | ERR                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v10** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v11** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | ERR                       | TP!                       | FN!                       |
| **v12** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | FN!                       |
| **v13** | FN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | FN!                       |
| **v14** | FN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       | FN!                       |
| **v2** | FN!                       | TN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | FN!                       |
| **v3** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | FN!                       |
| **v4** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       | TN!                       |
| **v5** | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v6** | FN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v7** | FN!                       | TP!                       | TP!                       | TP!                       | TN!                       | TP!                       | TP!                       | FN!                       |
| **v8** | FN!                       | TN!                       | TP!                       | TN!                       | TP!                       | TP!                       | TP!                       | FN!                       |
| **v9** | FN!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN!                       |
 

### Certora
|         | arbitrate-send            | auth-in-agree             | auth-in-dispute           | dispute-if-agree          | dispute-onlyif-agree      | no-send-in-agree          | recipient-buyer-or-seller | redeem-send               |
|---------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|---------------------------|
| **v1** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v10** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v11** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | ERR                       |
| **v12** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | FP!                       | TP!                       |
| **v13** | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       |
| **v14** | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | FP!                       | TP!                       |
| **v2** | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       |
| **v3** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       |
| **v4** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TN                        |
| **v5** | TN                        | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v6** | TP!                       | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       |
| **v7** | TP!                       | TP!                       | TP!                       | TP!                       | TN                        | TP!                       | TP!                       | TP!                       |
| **v8** | TP!                       | TN                        | TP!                       | TN                        | TP!                       | TP!                       | TP!                       | TP!                       |
| **v9** | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TP!                       | TN                        |
 

