// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimplePayable {
    function main(uint256 dummy, bytes memory deploymentBytecode) external payable returns (address addr) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // create it with the msg.value
            // do this as part of create, don't transfer it after
            // hint: use the `create` opcode
            // hint: the bytecode is already in memory
            let size := mload(deploymentBytecode) // Get the bytecode size
            let offset := add(deploymentBytecode, 0x20) // Get the offset where the bytecode actually begins 
            let contractAddress := create(callvalue(), offset, size) // Deploy the contract, sending msg.value to the constructor
            mstore(0x00, contractAddress) // Store the address
            return(0x00, 0x20) // Return the address
        }
    }
}
