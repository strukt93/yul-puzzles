// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SendEther {

    function main(address payable to, uint256 amount) external payable {
        assembly {
            pop(call(gas(), to, amount, 0, 0, 0, 0)) // pop() is just so the value is discarded and we get no errors
        }
    }
}