// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DoubleOrNothing {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            mstore(0x00, mul(x, 2))
            switch gt(x, 10)
            case 0 { return(0x00, 0x20) }
            case 1 { return(0x00, 0x00) }
            default { return(0x00, 0x00) }
        }
    }
}
