// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        bytes4 selector = bytes4(abi.encodeWithSignature("Panic(uint256)"));

        assembly {
            let len := sload(0x00) // readMe's slot is 0, we load its length from there

            if gt(index, sub(len, 1)) { // Panic if the index is bigger than the array length - 1
                mstore(0x00, selector)
                mstore(0x04, 0x32)
                revert(0x00, 0x24)
            }

            // Otherwise read the target index's slot and return it
            mstore(0x00, readMe.slot)
            mstore(0x00, keccak256(0x00, 0x20))
            mstore(0x20, sload(add(mload(0x00), index)))
            return(0x20, 0x20)
        }
    }
}
