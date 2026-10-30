
/// owner-only-recv:
/// only the owner can receive ETH from the contract.

// Will yield a false negative if the call exists but will always be reverted.

ghost bool violated {
    init_state axiom violated == false;
}

hook CALL(uint g, address addr, uint value, uint argsOffset, uint argsLength, uint retOffset, uint retLength) uint rc {
    if (addr != currentContract.owner && value != 0) {
        violated = true;
    }
}

rule owner_only_recv {
    assert(violated == false);
}