// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract FizzBuzz {
    function main(uint256 num) external pure returns (string memory) {
        assembly {
            let x := iszero(mod(num, 0x03))
            let y := iszero(mod(num, 0x05))
            mstore(0x00, 0x20)
            if x {
                if y {
                    mstore(0x20, 0x08)
                    mstore(0x40, "fizzbuzz")
                    return (0x00, 0x60)
                }
                mstore(0x20, 0x04)
                mstore(0x40, "fizz")
                return (0x00, 0x60)
            }
            if y {
                mstore(0x20, 0x04)
                mstore(0x40, "buzz")
                return (0x00, 0x60)
            }
            mstore(0x20, 0x00)
            return(0x00, 0x60)
        }
    }
}
