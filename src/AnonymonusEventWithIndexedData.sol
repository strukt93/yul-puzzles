// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithIndexedData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address emitter, bytes32 id, uint256 num) external {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, num)
            log3(ptr, 0x20, 0x0, emitter, id)
        }
    }
}
