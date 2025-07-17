// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        assembly {
            let selector := shr(224, calldataload(0)) // Get the selector by shifting the first 32 calldata bytes 224 bits to the left

            switch selector
            case 0x771602f7 { // Add function call
                getParams()
                sstore(0x00, add(mload(0x00), mload(0x20)))
            }
            case 0xb67d77c5 { // Sub function call
                getParams()
                sstore(0x00, sub(mload(0x00), mload(0x20)))
            }
            case 0xc8a4ac9c { // Mul function call
                getParams()
                sstore(0x00, mul(mload(0x00), mload(0x20)))
            }
            case 0xa391c15b { // Div function call
                getParams()
                sstore(0x00, div(mload(0x00), mload(0x20)))
            }
            default {
                revert(0,0)
            }

            function getParams() {
                if lt(calldatasize(), 68) { // 4 bytes function selector + 32 bytes first operand + 32 bytes second operand
                    revert(0,0)
                }

                mstore(0x00, calldataload(0x04)) // Store the first operand at memory slot 0
                mstore(0x20, calldataload(0x24)) // Store the second operand at memory slot 1
                leave // Return
            }
        }

        // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
        // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
        // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
        // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)
    }
}
