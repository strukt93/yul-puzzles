// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DoubleOrNothing {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            if lt(x, 11) {
                mstore(0x00, mul(x, 2))
            }
            return(0x00, 0x20)
        }
    }
}
