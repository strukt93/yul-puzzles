// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithIndexedData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address emitter, bytes32 id, uint256 num) external {
        bytes4 sig = bytes4(keccak256("MyEvent(address,bytes32,uint256)"));
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, num)
            log3(ptr, 0x20, sig, emitter, id)
        }
    }
}
