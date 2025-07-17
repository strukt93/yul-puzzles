// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Tenary {
    uint256 public result;

    function main(uint256 a, uint256 b, uint256 c) external {
        assembly {
            if gt(a, b) {
                sstore(result.slot, 10)
                return(0,0)
            }
            
            if gt(b, c) {
                sstore(result.slot, 20)
                return(0,0)
            }
            sstore(result.slot, 30)
        }
    }
}
