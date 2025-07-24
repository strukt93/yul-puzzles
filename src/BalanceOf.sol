// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BalanceOf {
    // emit these
    function main(address token) external view returns (uint256) {
        assembly {
            // your code here
            // return the balance of this contract using ERC20 "token"
            // assume "token" is an ERC20 contract
            // hint: balanceOf has function selector 0x70a08231 and signature "balanceOf(address)"
            // hint: since this is a view function, you should use staticcall
            // hint: use `returndatacopy` to copy the return data to the memory
            mstore(0x00, 0x70a08231) // Store the function selector
            mstore(0x20, address()) // Store address(this)
            pop(staticcall(gas(), token, 28, 36, 0, 0)) // Call the token's balanceOf function
            returndatacopy(0x00, 0x00, returndatasize()) // Copy the return data from the stack to the memory
            return(0x00, 0x20) // Return the copied return data
       }
    }
}

