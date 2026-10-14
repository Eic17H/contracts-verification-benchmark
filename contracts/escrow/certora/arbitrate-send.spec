ghost mathint sent;

hook CALL(uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if (addr == currentContract.arbiter) {
        // The value of `sent` can be havocked before the call, so it cannot be an accumulator.
        // The test will fail if the ETH is sent with multiple calls.
        // sent = sent + value
        sent = value;
    }
}

rule arbitrate_send {   

    env e;
    require e.msg.sender == currentContract.arbiter;

    address a;
    require a == currentContract.seller || a == currentContract.buyer;

    // require sent == 0
    currentContract.arbitrate(e, a);

    assert sent == to_mathint(currentContract.fee);
}
