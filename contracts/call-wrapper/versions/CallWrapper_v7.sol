// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `callwrap` always reverts, `receive` always reverts.
contract CallWrapper {
    uint data = 0;

    function callwrap(address called) public {
        require(false);
    }

    function modifystorage(uint newdata) public {
        require(false);
    }

    receive() external payable {
        require(false);
    }

}