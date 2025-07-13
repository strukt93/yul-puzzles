// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToFixedArray {
    uint256[5] writeHere;

    function main(uint256[5] memory x) external {
        assembly {
            let loc := 0x4
            for { let i := 0 } lt(i, 5) { i := add(i, 1) } {
                sstore(add(writeHere.slot, i), calldataload(loc))
                loc := add(loc, 0x20)
            }
        }
    }

    function getter() external view returns (uint256[5] memory) {
        return writeHere;
    }
}
