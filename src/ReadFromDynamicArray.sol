// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArray {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            /*
            Dynamic arrays are stored by keccak256() their slots and adding
            an index to them. So we:
            1. Get the storage slot of readMe
            2. keccak256() it
            3. Add the index to it
            4. sload whatever that is and return it
            */
            mstore(0x00, readMe.slot)
            mstore(0x00, keccak256(0x00, 0x20))
            mstore(0x20, sload(add(mload(0x00), index)))
            return(0x20, 0x20)
        }
    }
}
