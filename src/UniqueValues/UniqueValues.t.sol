// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {UniqueValues} from "src/UniqueValues/UniqueValues.sol";

contract UniqueValuesTest is Test {
    UniqueValues public uv;

    function setUp() public {
        uv = new UniqueValues();
    }

    function test_unique() public {
        uint256[] memory input = new uint256[](3);
        input[0] = 1;
        input[1] = 1;
        input[2] = 2;

        uint256[] memory uniqueValues = uv.extractUnique(input);

        for (uint256 i = 0; i < uniqueValues.length; i++) {
            console.log(uniqueValues[i]);
        }
    }

    function test_unique_multiple_calls() public {
        uint256[] memory input = new uint256[](3);
        input[0] = 1;
        input[1] = 1;
        input[2] = 2;

        uint256[] memory uniqueValues = uv.extractUnique(input);

        console.log("First call");
        for (uint256 i = 0; i < uniqueValues.length; i++) {
            console.log(uniqueValues[i]);
        }

        uint256[] memory uniqueValuesSecond = uv.extractUnique(input);

        console.log("Second call");
        for (uint256 i = 0; i < uniqueValuesSecond.length; i++) {
            console.log(uniqueValuesSecond[i]);
        }
    }
}
