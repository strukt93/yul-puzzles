// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithData {
    // EMIT ME!!!
    event MyEvent(uint256 number);

    function main(uint256 _number) external {
        bytes4 sig = bytes4(keccak256("MyEvent(uint256)"));
        assembly {
            mstore(0x00, _number)
            log1(0x00, 0x20, sig)
        }
    }
}
