// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            mstore(0x00, 0x40) //Store where "Hello" starts
            mstore(0x20, 0x80) //Store where "RareSkills" starts
            mstore(0x40, 0x05) //Store the length of "Hello"
            mstore(0x60, "Hello") //Store "Hello" itself
            mstore(0x80, 0x0a) //Store the length of "RareSkills"
            mstore(0xa0, "RareSkills") //Store "RareSkills" itself
            return(0x00, 0xc0) //Return the full memory block
        }
    }
}
