// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CountingSort {
    // Performs Counting Sort on the input array up to a specified maxValue.
    function countingSort(uint256[] calldata input, uint256 maxValue)
        public
        pure
        returns (uint256[] memory)
    {
        // Step 1: Initialize count array with (maxValue + 1) zeros
        uint256[] memory count = new uint256[](maxValue + 1);

        // Step 2: Store the count of each element in count array
        for (uint256 i = 0; i < input.length; i++) {
            require(input[i] <= maxValue, "Input value exceeds maxValue");
            count[input[i]] += 1;
        }

        // Step 3: Change count[i] so it contains the actual position of this element in output array
        for (uint256 i = 1; i <= maxValue; i++) {
            count[i] += count[i - 1];
        }

        // Step 4: Build the output character array
        // To keep it stable we are operating in reverse order.
        uint256[] memory output = new uint256[](input.length);
        for (int256 i = int256(input.length) - 1; i >= 0; i--) {
            output[count[input[uint256(i)]] - 1] = input[uint256(i)];
            count[input[uint256(i)]] -= 1;
        }

        return output;
    }
}
