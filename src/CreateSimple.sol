// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimple {
    function main(bytes memory deploymentBytecode) external returns (address addr) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: the bytecode is already in memory
            let size := mload(deploymentBytecode) // Get the size of the bytecode
            let contractAddress := create(0, add(deploymentBytecode, 0x20), size) // Create the contract and save the address
            mstore(0x00, contractAddress) // Store the address
            return(0x00, 0x20) // Return the address
        }
    }
}
