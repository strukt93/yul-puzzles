// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfTwoValues {
    function main(uint256 x, uint256 y) external pure returns (uint256) {
        assembly {
            if gt(x, y){
                mstore(0x00, x)
                return(0x00, 0x20)
            }
            mstore(0x00, y)
            return(0x00, 0x20)
        }
    }
}
