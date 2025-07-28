// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfStringUnit256 {
    function main() external pure returns (string memory, uint256) {
        assembly {
            //Since we return a (string,uint256) tuple, we first store the pointer
            //to the string and then immediately we store the uint256 value. Basically
            //the pointer is considered the actual beginning of the string.
            mstore(0x00, 0x40) //Store the pointer to the string
            mstore(0x20, 420) //Store the uint256 value
            mstore(0x40, 0xa) //Store the length of the string
            mstore(0x60, "RareSkills") //Store the string iteself
            return(0x00, 0x80) //Return the full memory block
        }
    }
}
