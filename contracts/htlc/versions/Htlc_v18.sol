// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

/// @custom:version all methods do nothing, but revert when they're supposed to.
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
        require(msg.sender == owner);
        require(msg.value >= fee);
        require(!isCommitted);
    }

    function reveal(string memory s) public {
        require(msg.sender == owner);
        require(hashing(s) == hash);
        require(isCommitted);
    }

    function timeout() public {
        require(block.number > start + waitTime);
        require(isCommitted);   
    }

    function hashing(string memory s) public pure returns (bytes32){
        return keccak256(abi.encodePacked(s));
    }
}
