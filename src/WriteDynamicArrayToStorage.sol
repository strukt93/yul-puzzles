// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            let len := calldataload(0x24) // Get the length of x
            sstore(writeHere.slot, len) // The writeHere array slot holds its length, which will be x's length so we store that
            let slot := keccak256(0x00, 0x20) // The first memory slot holds 0x00 by default, writeHere's slot is also the first in storage so we just keccak256() that
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let loc := mul(0x20, i) // x's items are placed in 32 byte increments
                let val := calldataload(add(0x44, loc)) // The first item in x is at calldata[0x44], we we load them in 32-byte increments
                sstore(add(slot, i), val) // We then store the values in writeHere by adding the index to the keccak256() of its slot
            }
        }
    }
}
