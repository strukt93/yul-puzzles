// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AbsoluteValue{

  function main(int256 x) external pure returns (uint256) {
      assembly {
        let abs := x
        let negative_one := 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        if slt(x, 0) {
          abs := sdiv(x, negative_one)
        }
        mstore(0x00, abs)
        return(0x00, 0x20)
      }
  }
}
