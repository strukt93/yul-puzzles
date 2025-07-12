// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelector {
    error RevertData(); // selector: 0xa3b7e096

    function main() external pure {
        assembly {
            mstore(0x00, 0xa3b7e096) //Will be stored at bytes 28-31 of the first memory slot
            revert(0x1c, 0x04) //0x1c is 28 in decimal
        }
    }
}
