// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromPacked64 {
    uint64 someValue1;
    uint64 someValue2;
    uint64 readMe;
    uint64 someValue3;

    function setValue(uint64 v1, uint64 v2, uint64 v3, uint64 v4) external {
        someValue1 = v1;
        someValue2 = v2;
        readMe = v3;
        someValue3 = v4;
    }

    function main() external view returns (uint256) {
        assembly {
            let packed := sload(0x00)
            packed := shr(128, packed)
            mstore(0x00, and(packed, 18446744073709551615)) //Decimal representation of 0000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
            return(0x00, 0x20)
        }
    }
}
