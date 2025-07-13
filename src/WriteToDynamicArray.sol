// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        uint256 len = x.length;
        assembly {
            mstore(0x00, 0x02) // Get the initial array slot
            let loc := 0x20
            let initial := keccak256(0x00, 0x20) // Hash the first array slot
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                sstore(add(initial, i), 0x1337)
                loc := add(loc, 0x20)
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
