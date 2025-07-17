// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract keccakX {
    function main(uint256 x) external pure returns (bytes32) {
        assembly {
            mstore(0x00, x) // Store x at the 0th memory slot
            mstore(0x20, keccak256(0x00, 0x20)) // keccak256() the 0th (1st) memory word and store it at the second memory slot
            return(0x20, 0x20) // Return the second memory slot's value
        }
    }
}
