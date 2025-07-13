// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelectorPlusArgs {
    error RevertData(uint256); // selector: 0xae412287

    function main(uint256 x) external pure {
        bytes4 selector = bytes4(abi.encodeWithSignature("RevertData(uint256)"));
        assembly {
            mstore(0x00, selector) // Store the selector at memory slot (higher 4 bytes)
            mstore(0x04, x) // Store the arg value at bytes 0x04-0x24
            revert(0x00, 0x24) // Return bytes 0x0-0x24 (4 bytes selector + 0x20 bytes arg)
        }
    }
}
