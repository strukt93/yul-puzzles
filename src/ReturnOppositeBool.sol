// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnOppositeBool {
    function main(bool _bool) external pure returns (bool) {
        assembly {
            let b := calldataload(0x24)
            let res := xor(b, 1)
            mstore(0x00, res)
            return(0x20, 0x20)
        }
    }
}
