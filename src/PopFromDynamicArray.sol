// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            let length := sload(0x00) // popFromMe's slot is 0, we load its length from there
            let newLength := sub(length, 1) 
            sstore(0x00, newLength) // We overwrite the length and decrement it by 1 since we pop a single item from the array
            let slot := keccak256(0x00, 0x20)  // We hash the slot so we know where the first actual item is
            sstore(add(slot, newLength), 0x00) // We then zero out the previous last slot of the array
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
