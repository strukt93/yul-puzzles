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
            /*
            let offset := person.offset
            let name_offset := calldataload(offset)
            let name_length := calldataload(add(offset, 0x20))
            let ptr := mload(0x40)
            mstore(ptr, name_offset)
            mstore(add(ptr, 0x20), name_length)
            let loc := add(ptr, 0x40)
            for {let i := 0x00} lt(i, name_length) { i := add(i, 0x01)} {
                mstore(loc, calldataload())
            }
            log3(ptr, add(len, 0x40), 0x0, emitter, id)
            */
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
