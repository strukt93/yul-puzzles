// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnSimpleStruct {
    // STRUCT
    struct Point {
        uint256 x;
        uint256 y;
    }

    function main(uint256 x, uint256 y) external pure returns (Point memory) {
        assembly {
            //Structs are just a bunch of values packed together
            mstore(0x00, x) //We store x at the first memory slot
            mstore(0x20, y) //y at the second
            return(0x00, 0x40) //Then we return the full block
        }
    }
}
