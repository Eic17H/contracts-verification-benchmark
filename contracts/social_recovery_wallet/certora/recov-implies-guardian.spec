// if an address `addr` has participated in a recovery, then `addr` is a guardian.
// Should fail in v1 because guardians can be removed.

rule recov_implies_guardian {

    address newOwner;
    env e;

    require e.msg.value == 0;

    bool senderHasParticipatedInARecovery = currentContract.guardianToRecovery[e.msg.sender].usedInExecuteRecovery;

    // Call an onlyGuardian method to check that the sender is a guardian

    // The method can only revert if the contract isn't in recovery state, if the sender isn't a guardian, and in case of an overflow
    // If one condition is met, then the other one is the only one that determines the revert
    require currentContract.inRecovery;
    supportRecovery@withrevert(e, newOwner);
    bool senderIsGuardian = !lastReverted;

    // Whether the sender is a guardian can't be checked directly by reading isGuardian[]
    // because keccak256(abi.encodePacked()) can't be replicated in Certora.
    // The workaround doesn't work with invariants,
    // and a normal rule can start from an invalid state, yielding false negatives.
    // This checks guardian status indirectly, and will yield false results if the link between supportRecovery and guardian status is changed.

    assert senderHasParticipatedInARecovery => senderIsGuardian;
}
