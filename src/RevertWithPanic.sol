// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithPanic {
    function main() external pure {
        bytes4 selector = bytes4(abi.encodeWithSignature("Panic(uint256)"));
        assembly {
            mstore(0x00, selector) // Store selector at memory slot 0
            mstore(0x04, 0x01) // Store 0x01 error code as required
            revert(0x00, 0x24) // Return the first 0x0-0x024 bytes of memory
        }
    }
}
