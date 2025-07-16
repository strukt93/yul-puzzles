// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromPacked128 {
    uint128 someValue;
    uint128 readMe;

    function setValue(uint128 v1, uint128 v2) external {
        someValue = v1;
        readMe = v2;
    }

    function main() external view returns (uint256) {
        assembly {
            let packed := sload(readMe.slot)
            let shifted := shr(128, packed)
            mstore(0x00, shifted)
            return(0x00, 0x20)
        }
    }
}
