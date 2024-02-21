// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Reentrancy {
    // A constant key for the reentrancy guard stored in Transient Storage.
    // This acts as a unique identifier for the reentrancy lock.
    bytes32 constant REENTRANCY_GUARD = keccak256("REENTRANCY_GUARD");

    // Modifier to prevent reentrant calls.
    // It checks if the reentrancy guard is set (indicating an ongoing execution)
    // and sets the guard before proceeding with the function execution.
    // After the function executes, it resets the guard to allow future calls.
    modifier nonReentrant() {
        // Ensure the guard is not set (i.e., no ongoing execution).
        require(tload(REENTRANCY_GUARD) == 0, "Reentrant call detected.");
        // Set the guard to block reentrant calls.
        tstore(REENTRANCY_GUARD, 1);
        _; // Execute the function body.
        // Reset the guard after execution to allow future calls.
        tstore(REENTRANCY_GUARD, 0);
    }

    // An example function that can call external contracts securely using the nonReentrant modifier.
    // This function is designed to prevent reentrant attacks by ensuring that callback cannot be re-entered
    // while it's still executing.
    function callback(address target, bytes memory data) public nonReentrant {
        // Calls an external contract or function with provided data.
        // Note: This is a low-level call; in production, consider checking the return value for success.
        target.call(data);
    }

    // Private helper function to simulate writing to Transient Storage.
    // It represents setting a value at a specific location in Transient Storage.
    function tstore(bytes32 location, uint256 value) private {
        assembly {
            // Assembly opcode to store 'value' at 'location' in Transient Storage.
            // Note: In this hypothetical example, 'tstore' represents a direct storage operation.
            tstore(location, value)
        }
    }

    // Private helper function to simulate reading from Transient Storage.
    // It represents fetching a value from a specific location in Transient Storage.
    function tload(bytes32 location) private returns (uint256 value) {
        assembly {
            // Assembly opcode to load and return a value from 'location' in Transient Storage.
            // Note: In this hypothetical example, 'tload' represents a direct storage operation.
            value := tload(location)
        }
    }
}
