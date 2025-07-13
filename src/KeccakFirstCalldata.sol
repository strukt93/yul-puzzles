// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakFirstCalldata {
    function main(uint256, uint256, uint256) external pure returns (bytes32) {
        assembly {
            mstore(0x00, calldataload(4)) // Leave the first 4 bytes (selector) and load the next 32 bytes, store them at memory slot 0
            mstore(0x20, keccak256(0x00, 0x20)) // keccak256() the value
            return(0x20, 0x20) // Return it
        }
    }
}
