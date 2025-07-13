// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            mstore(0x00, 0x01) // Store 1 at the first memory slot for the true case
            mstore(0x20, 0x00) // Store 0 at the second memory slot for the false case
            if eq(x, 1) { // 1 is a special case
                return(0x20, 0x20)
            }
            let mid := div(x, 2) // Track the midpoint
            for { let i := 2 } lt(i, mid) { i := add(i, 1) } { // Loop until the midpoint
                if eq(mod(x, i), 0) {
                    return(0x20, 0x20) // Return false if x is divisible by i
                }
            }
            return(0x00, 0x20) // Return true if the loop terminated and didn't return
        }
    }
}
