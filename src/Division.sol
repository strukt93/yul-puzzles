// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Division {

    function main(int256 x, int256 y) external pure returns (int256) {
        assembly {
            if eq(y, 0x00) {
                revert(0,0)
            }
            mstore(0x00, sdiv(x, y))
            return(0x00, 0x20)
       }
    }
}
