// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnOppositeBool {
    function main(bool _bool) external pure returns (bool) {
        assembly {
            let res := xor(_bool, 0x01)
            mstore(0x00, res)
            return(0x00, 0x20)
        }
    }
}
