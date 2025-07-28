// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SetBit {

  function main(uint256 x, uint8 i) external pure returns (uint256) {
      assembly {
          let a := 0x01
          a := shl(i, a)
          mstore(0x00, or(a, x))
          return(0x00, 0x20)
     }
  }
}
