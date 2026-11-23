// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `callwrap` increments `data`.
contract CallWrapper {
    uint data = 0;

    function callwrap(address called) public {
        data = data + 1;
        called.call("");
    }

}