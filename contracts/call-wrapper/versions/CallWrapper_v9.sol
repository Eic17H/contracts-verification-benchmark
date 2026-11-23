// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

/// @custom:version reentrant `callwrap` calls `msg.sender` instead of `called`.
contract CallWrapper {
    uint data = 0;

    function callwrap(address called) public {
        msg.sender.call("");
    }

}