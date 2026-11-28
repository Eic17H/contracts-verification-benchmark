// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./lib/ReentrancyGuard.sol";

/// @custom:version conformant to specification.

contract SocialRecoveryWallet is ReentrancyGuard {

    uint round; // current recovery round
    address owner; // current owner of the wallet
    mapping(bytes32 => bool) guardianHashList; // current guardians

    // Contract parameters
    uint guardianThreshold;

    // Recovery state
    mapping(uint => uint) supportingGuardianCount; // the key is the round
    mapping(uint => address) proposedOwner; // the key is the round
    mapping(address => uint) supportingGuardians; // the key is the guardian, the value is the latest round
    bool inRecovery;

    // Removal state
    mapping(bytes32 => uint256) guardianRemovalTimestamp;
    mapping(bytes32 => bool) guardianProposedRemoval;

    // Address management

    function hashAddress(address a) internal pure returns (bytes32) {
        return bytes32(abi.encode(a));
    }

    function isGuardian(address a) internal view returns (bool) {
        return isGuardianHash(hashAddress(a));
    }

    function isGuardianHash(bytes32 hash) internal view returns (bool) {
        return guardianHashList[hash];
    }

    function addGuardian(bytes32 hash) internal {
        guardianHashList[hash] = true;
    }

    function removeGuardian(bytes32 hash) internal {
        guardianHashList[hash] = false;
    }

    // Basic functions

    constructor(bytes32[] memory guardians, uint256 threshold) {
        uint256 guardianCount = 0;
        for(uint i = 0; i < guardians.length; i++) {
            if(!guardianHashList[guardians[i]]) {
                guardianHashList[guardians[i]] = true;
                guardianCount += 1;
            }
        }
        require(threshold <= guardianCount);
        guardianThreshold = threshold;
        owner = msg.sender;

    }

    function executeExternalTx(address recipient, bytes memory data) public payable nonReentrant {
        (bool success,) = recipient.call{value: msg.value}(data);
        require(success);
    }

    // Recovery

    function initiateRecovery(address newOwner) public nonReentrant {
        require(isGuardian(msg.sender));

        // Must not already be in a recovery
        require(!inRecovery);

        // Must make sense
        require(newOwner != owner);
        require(!isGuardian(newOwner));

        // Reset supporting guardians
        round += 1;

        // Automatically support the recovery
        supportingGuardianCount[round] = 1;
        supportingGuardians[msg.sender] = round;

        // Initiate recovery
        proposedOwner[round] = newOwner;
        inRecovery = true;
    }

    function supportRecovery(address newOwner) public nonReentrant {
        require(isGuardian(msg.sender));
        require(newOwner == proposedOwner[round]);

        // Must be in a recovery
        require(inRecovery);

        // Cannot support twice
        require(supportingGuardians[msg.sender] != round);

        // Support recovery
        supportingGuardianCount[round] += 1;
        supportingGuardians[msg.sender] = round;
    }

    function executeRecovery() public nonReentrant {
        require(isGuardian(msg.sender));

        // Must be in a recovery
        require(inRecovery);

        // Recovery must be supported
        require(supportingGuardianCount[round] >= guardianThreshold);

        // Execute recovery
        owner = proposedOwner[round];

        // Reset recovery
        inRecovery = false;
    }

    // Guardian removal

    function initiateGuardianRemoval(bytes32 hash) public nonReentrant {
        require(msg.sender == owner);
        require(isGuardianHash(hash));
        require(!guardianProposedRemoval[hash]);
        guardianRemovalTimestamp[hash] = block.timestamp + 3 days;
        guardianProposedRemoval[hash] = true;
    }

    function executeGuardianRemoval(bytes32 hash, bytes32 hash2) public nonReentrant {
        require(msg.sender == owner);
        require(isGuardianHash(hash));
        require(guardianProposedRemoval[hash]);
        require(guardianRemovalTimestamp[hash] <= block.timestamp);
        removeGuardian(hash);
        addGuardian(hash2);
        guardianProposedRemoval[hash] = false;
    }

    function cancelGuardianRemoval(bytes32 hash) public nonReentrant {
        require(msg.sender == owner);
        require(isGuardianHash(hash));
        require(guardianProposedRemoval[hash]);
        guardianProposedRemoval[hash] = false;
    }
}