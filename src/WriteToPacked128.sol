// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked128 {
    uint128 public writeHere = 1;
    uint128 public someValue = 7;

    function main(uint256 v) external {
        assembly {
            let slot := writeHere.slot // Get the slot we want to write to
            let initial := sload(slot) // Get the value at the slot (the full, packed value)
            initial := shr(128, initial) // Shift right 128 bits to zero out the lower 16 bytes
            initial := shl(128, initial) // Shift left 128 bits to get `someValue` back to the higher 16 bytes
            sstore(slot, or(initial, v)) // Store the or() output of our values
        }
    }
}
