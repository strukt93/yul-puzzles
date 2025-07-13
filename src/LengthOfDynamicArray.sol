// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract LengthOfDynamicArray {
    function main(uint256[] memory x) external view returns (uint256) {
        assembly {
            /*
            Head of a dynamic data type is its location in memory, at which is its size.
            We only have a single dynamic array as argument so we have:
            1. The first 4 bytes function selector
            2. 32 bytes indicating its location (which is the next 32 bytes so we can just hardcode that)
            3. 32 bytes actually representing the array length

            As such, the size is at memory position 0x24 (36 in decimal)
            */
            mstore(0x00, calldataload(0x24))
            return(0x00, 0x20)
        }
    }
}
