// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Return42 {

  function main() external pure returns (uint256) {
      assembly {
          mstore(0x00, 42) //Store 42 (decimal) in the first memory slot
          return(0x00, 0x20) //Return the first memory slot's 32 bytes
      }
  }
}
