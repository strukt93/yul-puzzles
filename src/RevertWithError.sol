// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        bytes4 selector = bytes4(abi.encodeWithSignature("Error(string)")); 
        assembly {
            mstore(0x00, selector)
            mstore(0x04, 0x20) //String is dynamic so we store its location as the head
            mstore(0x24, 0x0c) //Actual string's location
            mstore(0x44, "RevertRevert") //String literal
            revert(0x00, 0x56) //Revert with the error selector + string
        }
    }
}
