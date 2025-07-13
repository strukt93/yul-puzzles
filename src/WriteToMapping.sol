// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToMapping {
    mapping(uint256 index => uint256) public writeHere;

    function main(uint256 index, uint256 value) external {
        assembly {
            let ptr := mload(0x40) // Load the free memory pointer
            mstore(ptr, index) // Store the index
            mstore(add(ptr, 0x20), writeHere.slot) // Store the mapping slot
            let loc := keccak256(ptr, 0x40) // keccak256(index ++ mapping)
            sstore(loc, value) // Write to the location in storage
        }
    }
}
