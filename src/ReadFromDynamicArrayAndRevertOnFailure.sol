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
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            mstore(0x00, readMe.slot)

            if lt(index, 0x00) {
                mstore(0x00, selector)
                mstore(0x04, 0x32)
                revert(0x00, 0x24)
            }

            if gt(index, sub(mload(0x00), 1)) {
                mstore(0x00, selector)
                mstore(0x04, 0x32)
                revert(0x00, 0x24)
            }

            mstore(0x00, keccak256(0x00, 0x20))
            mstore(0x20, sload(add(mload(0x00), index)))
            return(0x20, 0x20)
        }
    }
}
