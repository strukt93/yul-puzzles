// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleRevert {

  function main() external pure {
      assembly {
          revert(0,0)
      }
  }
}
