// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCallWithValue {

    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()" while sending msg.value
            // hint: "foo()" has function selector 0xc2985578
            // hint: callvalue() returns the value of the current call
            mstore(0x00, 0xc2985578) // Store foo's selector at memory slot 0x00 (will be bytes 28-31)
            pop(call(gas(), t, callvalue(), 28, 4, 0, 0)) // Call t and forward all the remaining gas, attach callvalue() as call value
       }
    }
}