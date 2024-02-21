// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UniqueValues {
    // Function to return unique values from an array of unsigned integers.
    // It takes an array as input and returns a new array with duplicate values removed.
    function extractUnique(uint256[] calldata input)
        public
        returns (uint256[] memory)
    {
        uint256 uniqueCount = 0; // Counter to keep track of the number of unique values found.

        // Initialize a new dynamic array in memory to store unique values.
        // Its initial size is the same as the input array, assuming all values could be unique.
        uint256[] memory uniqueValues = new uint256[](input.length);

        // Iterate over each value in the input array.
        for (uint256 i = 0; i < input.length; i++) {
            uint256 currentValue = input[i]; // Current value being checked.

            // Use the tload function to check if currentValue has already been marked as seen in Transient Storage.
            // If tload returns 0, it means this value has not been encountered before.
            if (tload(currentValue) == 0) {
                // Add the currentValue to the uniqueValues array and increment the uniqueCount.
                uniqueValues[uniqueCount++] = currentValue;

                // Mark this currentValue as seen by storing a 1 in its corresponding location in Transient Storage.
                tstore(currentValue, 1);
            }
        }

        // Resize the uniqueValues array to match the actual number of unique values found.
        // This is necessary because Solidity does not support dynamic memory array resizing.
        // The "memory-safe" flag ensures that the assembly code adheres to memory safety.
        assembly ("memory-safe") {
            mstore(uniqueValues, uniqueCount)
        }

        // Return the resized array containing only the unique values.
        return uniqueValues;
    }

    // Uses inline assembly to access the Transient Storage's tstore operation.
    function tstore(uint256 location, uint256 value) private {
        assembly {
            tstore(location, value)
        }
    }

    // Uses inline assembly to access the Transient Storage's tload operation.
    // Returns the value stored at the given location.
    function tload(uint256 location) private returns (uint256 value) {
        assembly {
            value := tload(location)
        }
    }
}
