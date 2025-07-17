// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(uint64 v1, uint64 v2, uint64 v3, uint64 v4, uint64 v5) external {
        assembly {
            let slot := writeHere.slot // Get writeHere's slot
            sstore(slot, 0x05) // Store the new legnth of the array, which is 5
            mstore(0x00, slot) // Store the slot in memory for the next operation
            let firstLoc := keccak256(0x00, 0x20) // Get the first item's slot
            let itemOne := or(0xffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000, v4) // Assign the slot's first 8 bytes to v4
            itemOne := shl(64, itemOne) // Shift v4 left by 8 bytes, repeat for all the values below
            itemOne := or(itemOne, v3)
            itemOne := shl(64, itemOne)
            itemOne := or(itemOne, v2)
            itemOne := shl(64, itemOne)
            itemOne := or(itemOne, v1) // Now itemOne looks like [v4][v3][v2][v1]
            sstore(firstLoc, itemOne) // Store itemOne in the first location of writeHere 

            let secondLoc := add(firstLoc, 1) // Get the next location to write to in writeHere
            let itemTwo := or(0xffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000, v5) // Create a new item to add to the array
            sstore(secondLoc, itemTwo) // Store the value
        }
    }
}
