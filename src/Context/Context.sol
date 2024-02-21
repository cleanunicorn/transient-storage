// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Context {
    // Slots for transient storage
    bytes32 private constant NUMBER_SLOT = keccak256("number");
    bytes32 private constant ADDRESS_SLOT = keccak256("address");

    // Sets a number in the transient storage
    function getNumber() public returns (uint256) {
        return uint256(tload(NUMBER_SLOT));
    }

    // Sets an address in the transient storage
    function getAddress() public returns (address) {
        return address(uint160(tload(ADDRESS_SLOT)));
    }

    // Sets values in transient storage and makes an external call
    function setAndCall(uint256 number, address addr, address execute) public {
        // Set context values
        tstore(NUMBER_SLOT, number);
        tstore(ADDRESS_SLOT, uint256(uint160(addr)));

        // Call external contract
        (bool success,) = execute.call("");
        require(success, "External call failed");

        // Reset context values
        tstore(NUMBER_SLOT, 0);
        tstore(ADDRESS_SLOT, 0);
    }

    // Writes to Transient Storage
    function tstore(bytes32 location, uint256 value) private {
        assembly {
            tstore(location, value)
        }
    }

    // Reads from Transient Storage
    function tload(bytes32 location) private returns (uint256 value) {
        assembly {
            value := tload(location)
        }
    }
}
