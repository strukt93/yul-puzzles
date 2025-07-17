// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromFixedArray {
    uint256[5] readMe;

    function setValue(uint256[5] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            mstore(0x00, sload(add(readMe.slot, index))) // Read the store at the readMe variable slot + index
            return(0x00, 0x20) // Return it
        }
    }
}
