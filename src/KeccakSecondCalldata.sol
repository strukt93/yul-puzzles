// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakSecondCalldata {
    function main(uint256, uint256, uint256) external pure returns (bytes32) {
        assembly {
            
            mstore(0x00, calldataload(0x24)) //Load the 32 bytes of calldata starting at 0x24 (4 bytes selector + 0x20 first argument)
            mstore(0x20, keccak256(0x00, 0x20)) // keccak256() the value
            return(0x20, 0x20) // Return it
        }
    }
}
