// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromMapping {
    mapping(uint256 index => uint256) readMe;

    function setValue(uint256 index, uint256 value) external {
        readMe[index] = value;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            let ptr := mload(0x40) // Load the free memory pointer
            mstore(ptr, index) // Store the index
            mstore(add(ptr, 0x20), readMe.slot) // Store the mapping slot
            let loc := keccak256(ptr, 0x40) // keccak256(index ++ mapping)
            mstore(0x00, sload(loc)) // Load from the storage
            return(0x00, 0x20) // Return the value
        }
    }
}
