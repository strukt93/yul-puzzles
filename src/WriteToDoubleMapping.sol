// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDoubleMapping {
    mapping(address user => mapping(address token => uint256 value)) public balances;

    function main(address user, address token, uint256 value) external {
        assembly {
            let ptr := mload(0x40) // Load the free memory pointer
            mstore(ptr, user) // Store the index
            mstore(add(ptr, 0x20), balances.slot) // Store the mapping slot
            mstore(add(ptr, 0x20), keccak256(ptr, 0x40)) // keccak256(user ++ mappingSlot) and store it at ptr + 0x20
            mstore(ptr, token) // Store token at ptr
            let loc := keccak256(ptr, 0x40) // keccak256(token ++ prevResult)
            sstore(loc, value) // Write to storage
        }
    }
}
