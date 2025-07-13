// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithoutData {
    // EMIT ME!!!
    event MyEvent();

    function main() external {
        bytes4 sig = bytes4(keccak256("MyEvent()"));
        assembly {
            log1(0x00, 0x00, sig)
        }
    }
}
