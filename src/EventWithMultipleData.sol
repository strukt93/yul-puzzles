// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithMultipleData {
    // EMIT ME!!!
    event MyEvent(address emitter, uint256 num, bool isActive);

    function main(address emitter, uint256 num, bool isActive) external {
        bytes4 sig = bytes4(keccak256("MyEvent(address,uint256,bool)"));
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, emitter)
            mstore(add(ptr, 0x20), num)
            mstore(add(ptr, 0x40), isActive)
            log1(ptr, 0x60, sig)
        }
    }
}
