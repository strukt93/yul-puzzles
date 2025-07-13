// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDoubleMapping {
    mapping(address user => mapping(address token => uint256)) public balances;

    function setValue(address user, address token, uint256 value) external {
        balances[user][token] = value;
    }

    function main(address user, address token) external view returns (uint256) {
        assembly {
            let ptr := mload(0x40) // Load the free memory pointer
            mstore(ptr, user) // Store the index
            mstore(add(ptr, 0x20), balances.slot) // Store the mapping slot
            mstore(add(ptr, 0x20), keccak256(ptr, 0x40)) // keccak256(user ++ mappingSlot) and store it at ptr + 0x20
            mstore(ptr, token) // Store token at ptr
            let loc := keccak256(ptr, 0x40) // keccak256(token ++ prevResult)
            mstore(0x00, sload(loc)) // Load from the storage
            return(0x00, 0x20) // Return the value
        }
    }
}
