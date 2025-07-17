// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalldataLength {
    function main(bytes calldata) external pure returns (uint256) {
        assembly {
            mstore(0x00, calldatasize()) // Store the size of the calldata at the memory's 0th slot
            return(0x00, 0x20) // Return it
        }
    }
}
