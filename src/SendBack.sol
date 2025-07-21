// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SendBack {

    fallback() external payable {
        assembly {
            pop(call(gas(), caller(), callvalue(), 0, 0, 0, 0))
        }
    }
}