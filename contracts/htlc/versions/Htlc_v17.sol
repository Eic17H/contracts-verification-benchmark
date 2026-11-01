// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

/// @custom:version all methods do nothing.
contract Htlc {
    address payable public owner;  
    address payable public verifier;
    bytes32 public hash;
    bool public isCommitted;
    uint public start;
    uint public fee;
    uint public waitTime;
    
    constructor(address payable v) {
        owner = payable(msg.sender);
        verifier = v;
        start = block.number;
        isCommitted = false;
        fee = 1 ether;
        waitTime = 1000;
    }

    function commit(bytes32 h) public payable {
    }

    function reveal(string memory s) public {
    }

    function timeout() public {
    }

    function hashing(string memory s) public pure returns (bytes32){
        return keccak256(abi.encodePacked(s));
    }
}
