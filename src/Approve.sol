// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Approve {
    // emit these
    function main(address token, uint256 amount) external {
        assembly {
            // your code here
            // approve "token" to spend "amount"
            // hint: approve has function selector 0x095ea7b3 and signature "approve(address,uint256)"
            let fp := mload(0x40) // Load the free memory pointer
            mstore(fp, 0x095ea7b3) // Store the function selector
            mstore(add(fp, 0x20), token) // Store the spender, the token in this case
            mstore(add(fp, 0x40), amount) // Store the allowance amount
            mstore(0x40, add(fp, 0x60)) // Update the free memory pointer, not required but cleaner
            pop(call(gas(), token, 0, add(fp, 28), 68, 0, 0)) // Call the token's approve function
       }
    }
}

