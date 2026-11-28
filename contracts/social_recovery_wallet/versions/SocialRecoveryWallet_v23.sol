// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./lib/ReentrancyGuard.sol";

/// @custom:version conformant to specification, reimplemented independently from v1.

contract SocialRecoveryWallet is ReentrancyGuard {

    constructor(bytes32[] guardians, uint256 threshold) {
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

    // Paragraph 1

    address owner;

    function executeExternalTx(address recipient, bytes memory data) public payable nonReentrant {
        (bool success,) = recipient.call{value: msg.value}(data);
        require(success);
    }

    // Paragraph 2

    uint guardianThreshold;
    uint supportingGuardianCount;
    address proposedOwner;
    mapping(address => bool) emptyAddressBoolMap;
    mapping(address => bool) supportingGuardians;
    bool inRecovery;

    function hashAddress(address a) internal returns (bytes32) {
        return bytes32(a);
    }

    function isGuardian(address a) internal returns (bool) {
        return isGuardianHash(hashAddress(a));
    }

    function initiateRecovery(address newOwner) public nonReentrant {
        require(isGuardian(msg.sender));

        // Must not already be in a recovery
        require(!inRecovery);

        // Must make sense
        require(newOwner != owner);
        require(!isGuardian(newOwner));

        // Reset supporting guardians
        supportingGuardians = emptyAddressBoolMap;

        // Automatically support the recovery
        supportingGuardianCount = 1;
        supportingGuardians[msg.sender] = true;

        // Initiate recovery
        proposedOwner = newOwner;
        inRecovery = true;
    }

    function supportRecovery(address newOwner) public nonReentrant {
        require(isGuardian(msg.sender));

        // Must be in a recovery
        require(inRecovery);

        // Cannot support twice
        require(!supportingGuardians[msg.sender]);

        // Support recovery
        supportingGuardianCount += 1;
        supportingGuardians[msg.sender] = true;
    }

    function executeRecovery() public nonReentrant {
        require(isGuardian(msg.sender));

        // Must be in a recovery
        require(inRecovery);

        // Recovery must be supported
        require(supportingGuardianCount >= guardianThreshold);

        // Execute recovery
        owner = proposedOwner;

        // Reset recovery
        inRecovery = false;
        supportingGuardianCount = 0;
        supportingGuardians = emptyAddressBoolMap;
    }

    // Paragraph 3

    function isGuardianHash(bytes32 hash) internal returns (bool) {
        return guardianHashList[hash];
    }

    mapping(bytes32 => uint256) guardianRemovalTimestamp;
    mapping(bytes32 => bool) guardianProposedRemoval;

    mapping(bytes32 => bool) guardianHashList;

    function addGuardian(bytes32 hash) internal {
        guardianHashList[hash] = true;
    }

    function removeGuardian(bytes32 hash) internal {
        guardianHashList[hash] = false;
    }

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