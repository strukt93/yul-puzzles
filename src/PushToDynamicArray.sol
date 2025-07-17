// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            let length := sload(0x00) // pushToMe's slot is 0, we load its length from there
            sstore(0x00, add(length, 1)) // We overwrite the length and increment it by 1 since we push a single item to the array
            let slot := keccak256(0x00, 0x20) // We hash the slot so we know where the first actual item is
            sstore(add(slot, length), newValue) // We then store newValue at the first item's slot + the array length
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}
