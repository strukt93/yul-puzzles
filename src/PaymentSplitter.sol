// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {

    function main(address[] calldata recipients) external payable {
        assembly {
            let len := recipients.length
            let amt := div(selfbalance(), len)
            //let offset := recipients.offset //Where the list of recipients actually starts in calldata
            let offset := 0x44
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let addr := calldataload(offset)
                pop(call(gas(), addr, amt, 0, 0, 0, 0))
                offset := add(offset, 0x20)
            }
        }
    }
}