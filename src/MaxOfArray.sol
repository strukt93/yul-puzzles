// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            let size := calldataload(0x24) // Extract the array size from calldata
            let loc := 0x44 // Location of the first array element
            let max := calldataload(loc) // First array element as an initial max
            for { let i := 0x01 } lt(i, size) { i := add(i, 0x01) } {
                loc := add(loc, 0x20) // Move location pointer to the next memory slot
                let curr := calldataload(loc) // Load the array item from memory
                if gt(curr, max) {
                    max := curr // Set the max if the item is greater than the latest max
                }
            }
            mstore(0x00, max) // Store the max
            return(0x00, 0x20) // Return it
        }
    }
}
