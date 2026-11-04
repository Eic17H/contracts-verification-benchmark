// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./lib/ReentrancyGuard.sol";

/// @custom:version all methods do nothing.
contract Wallet is ReentrancyGuard {

    // hash of guardian address
    mapping(bytes32 => bool) public isGuardian;
    uint256 public threshold;
    address public owner;
    bool public inRecovery;
    uint256 public currRecoveryRound;
    mapping(bytes32 => uint256) public guardianHashToRemovalTimestamp;

    /// @notice struct used for bookkeeping during recovery mode
    /// @dev trival struct but can be extended in future (when building for malicious guardians
    /// or when owner key is compromised)
    struct Recovery {
        address proposedOwner;
        uint256 recoveryRound; // recovery round in which this recovery struct was created
        bool usedInExecuteRecovery; // set to true when we see this struct in RecoveryExecute
    }

    mapping(address => Recovery) public guardianToRecovery;
     
    // ghost variables p1
    address _first_owner;
    
     // ghost variables p2
    bool _recovered;
    

    /************************************************
     *  MODIFIERS 
    ***********************************************/

    modifier onlyOwner {
        // require(msg.sender == owner, "only owner");
        _;
    }

    modifier onlyGuardian {
        // require(isGuardian[keccak256(abi.encodePacked(msg.sender))], "only guardian");
        _;
    }

    modifier notInRecovery {
        // require(!inRecovery, "wallet is in recovery mode");
        _;
    }

    modifier onlyInRecovery {
        // require(inRecovery, "wallet is not in recovery mode");
        _;
    }

    constructor(bytes32[] memory guardianAddrHashes, uint256 threshold_) {
        require(threshold_ <= guardianAddrHashes.length, "threshold too high");
        
        for(uint i = 0; i < guardianAddrHashes.length; i++) {
            require(!isGuardian[guardianAddrHashes[i]], "duplicate guardian");
            isGuardian[guardianAddrHashes[i]] = true;
        }
        
        threshold = threshold_;
        owner = msg.sender;
        
        //p1
        _first_owner = owner;
    }

    function executeExternalTx(address callee, 
        uint256 value, 
        bytes memory data
    ) external onlyOwner nonReentrant returns (bytes memory) {
        return data;
    }

    /************************************************
     *  Recovery
    ***********************************************/

    function initiateRecovery(address _proposedOwner) onlyGuardian notInRecovery external {
    }

    function supportRecovery(address _proposedOwner) onlyGuardian onlyInRecovery external {
    }

    function cancelRecovery() onlyOwner onlyInRecovery external {
    }

    function executeRecovery(address newOwner, address[] calldata guardianList) onlyGuardian onlyInRecovery external {
    }

    /************************************************
     *  Guardian Management
    ***********************************************/

    function initiateGuardianRemoval(bytes32 guardianHash) external onlyOwner {
    }

    function executeGuardianRemoval(bytes32 oldGuardianHash, bytes32 newGuardianHash) onlyOwner external {
    }

    function cancelGuardianRemoval(bytes32 guardianHash) onlyOwner external {
    }

}
