// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CountingSort} from "src/CountingSort/CountingSort.sol";

contract UniqueValuesTest is Test {
    CountingSort public cs;

    function setUp() public {
        cs = new CountingSort();
    }

    function test_sort_array() public {
        uint256[] memory input = new uint256[](4);
        input[0] = 4;
        input[1] = 1;
        input[2] = 2;
        input[3] = 2;

        uint256[] memory sorted = cs.countingSort(input, 5);
        for (uint256 i = 0; i < sorted.length; i++) {
            console.log(sorted[i]);
        }
    }
}
