// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromStorage {
    uint256 readMe;

    function setValue(uint256 x) external {
        readMe = x;
    }

    function main() external view returns (uint256) {
        assembly {
            mstore(0x00, sload(readMe.slot)) // Read the storage at the slot of the readMe variable
            return(0x00, 0x20) // Return the value
        }
    }
}
