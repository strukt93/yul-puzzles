// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1;
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            let slot := writeHere.slot // Get the slot we want to write to
            let initial := sload(slot) // Get the value at the slot (the full, packed value)
            let cleared := and(initial, 0xffffffffffffffffffffffffffffffff0000000000000000ffffffffffffffff) // Clear the 64 bits for writeHere
            let newV := shl(64, v) // Shift v 64 bits to the left so it aligns with the position of writeHere
            sstore(slot, or(cleared, newV)) // Or() the stuff and store it
        }
    }
}
