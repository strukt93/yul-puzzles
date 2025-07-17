// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnArrayOfUint256 {
    function main(uint256 a, uint256 b, uint256 c) external pure returns (uint256[] memory) {
        assembly {
            let ptr := mload(0x40) // Get the free memory pointer
            mstore(ptr, 0x20) // Store where the array begins
            mstore(add(ptr, 0x20), 3) // First array slot contains its length
            mstore(add(ptr, 0x40), a) // Next is the first item
            mstore(add(ptr, 0x60), b) // Next is the second item
            mstore(add(ptr, 0x80), c) // Next is the third item
            return(ptr, 0xa0) // Return the whole memory chunk
        }
    }
}
