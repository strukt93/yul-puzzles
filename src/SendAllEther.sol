// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SendAllEther {

    function main(address payable to) external payable {
        assembly {
            pop(call(gas(), to, selfbalance(), 0, 0, 0, 0)) // pop() is just so the value is discarded and we get no errors
        }
    }
}