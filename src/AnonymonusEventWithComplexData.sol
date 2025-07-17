// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            let len := calldataload(0x64)
            let ptr := mload(0x40)
            calldatacopy(ptr, add(0x64, 0x20), len)
            let next := add(ptr, len)
            calldatacopy(next, 0x84, 0x20)
            calldatacopy(add(next, 0x20), 0x104, 0x20)
            log3(ptr, add(len, 0x40), 0x0, emitter, id)
            // your code here
            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - string offset
            //          - string length offset
            //          - age
            //          - gender
            //          - name length
            //          - name
        }
    }
}
