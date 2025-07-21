// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {

    function main(address[] calldata recipients) external payable {
        assembly {
            let len := recipients.length
            let amt := div(selfbalance(), len)
            let pos := 16
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let addr := calldataload(pos)
                pop(call(gas(), addr, amt, 0, 0, 0, 0))
                pos := add(pos, 0x20)
            }
        }
    }
}