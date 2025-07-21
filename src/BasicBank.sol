// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // emit these
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances;

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        assembly {
            let ptr := mload(0x40) // Load the free memory pointer
            let sender := caller() // Track the caller
            let amt := callvalue() // Track the attached amount
            mstore(ptr, sender) // Store the index
            mstore(add(ptr, 0x20), balances.slot) // Store the mapping slot
            let loc := keccak256(ptr, 0x40) // keccak256(address ++ mapping)
            let newAmt := add(sload(loc), amt) // Total amount after deposit
            sstore(loc, newAmt) // Write the new amount to the location in storage
            mstore(ptr, amt) // Store msg.value in memory because it isn't indexed, overwrite ptr because YOLO
            log2(ptr, 0x20, depositSelector, sender) // Emit the event
        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;
        assembly {
            // emit Withdraw(msg.sender, amount)
            // if the balance is less than amount, revert InsufficientBalance()
            // decrement the balance of the msg.sender by amount
            // send the amount to the msg.sender
            let ptr := mload(0x40) // Load the free memory pointer
            let sender := caller() // Track the caller
            mstore(ptr, sender) // Store the caller
            mstore(add(ptr, 0x20), balances.slot) // Store the mapping slot
            let loc := keccak256(ptr, 0x40) // keccak256(address ++ mapping)
            let currentBalance := sload(loc) // Total amount after deposit
            if lt(currentBalance, amount) {
                mstore(0x00, insufficientBalanceSelector)
                revert(0x00, 0x04)
            }
            let amt := callvalue() // Track the attached amount
            let newAmt := sub(currentBalance, amount)
            sstore(loc, newAmt) // Write the new amount to the location in storage
            mstore(ptr, amt) // Store msg.value in memory because it isn't indexed, overwrite ptr because YOLO
            pop(call(gas(), sender, amount, 0, 0, 0, 0))
            log2(ptr, 0x20, withdrawSelector, sender) // Emit the event
        }
    }
}