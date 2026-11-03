// during a successful call to `arbitrate`, the contract sends the arbiter `fee` ETH.

function invariant(address dst) public {

    require (msg.sender == arbiter);

    require (dst == buyer || dst == seller);

    require (msg.sender != address(this));
    require (dst != address(this));

    uint oldbal = msg.sender.balance;

    arbitrate(dst);

    uint newbal = msg.sender.balance;

    uint sent = newbal - oldbal;

    assert (sent == fee);

}