// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfUint256String {
    function main() external pure returns (uint256, string memory) {
        assembly {
            mstore(0x00, 420) //Store the uint256 value
            mstore(0x20, 0x40) //Store the offset where the string begins
            mstore(0x40, 0xa) //Store the length of the string
            mstore(0x60, "RareSkills") //Store the string iteself
            return(0x00, 0x80) //Return the full memory block
        }
    }
}
