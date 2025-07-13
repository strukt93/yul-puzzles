// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToStorage {
    uint256 public writeHere;

    function main(uint256 x) external {
        assembly {
            sstore(writeHere.slot, x) // Store x at the slot of writeHere
        }
    }
}
