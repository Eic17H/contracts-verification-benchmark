rule arbitrate_send {   


    env e;
    require e.msg.sender == currentContract.arbiter;

    address a;
    require a == currentContract.seller || a == currentContract.buyer;

    // trivial checks to rule out unrealistic scenarios
    require(e.msg.sender != currentContract);
    require a != currentContract;

    mathint oldbal = nativeBalances[e.msg.sender];

    currentContract.arbitrate(e, a);

    mathint newbal = nativeBalances[e.msg.sender];

    mathint sent = newbal - oldbal;

    assert sent == to_mathint(currentContract.fee);
}
