// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnString {
    function main() external pure returns (string memory) {
        assembly {
            let ptr := mload(0x40) // Get the free memory pointer
            mstore(ptr, 0x20) // Store where the byte array begins
            mstore(add(ptr, 0x20), 17) // First array slot contains its length
            mstore(add(ptr, 0x40), "Hello, RareSkills") // We keep the full string at the next slot since it is less than 32 bytes long
            return(ptr, 0x60) // Return the memory chunk
        }
    }
}
