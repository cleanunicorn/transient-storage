// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Transient} from "src/Transient.sol";

contract CounterTest is Test {
    Transient public transient;

    function setUp() public {
        transient = new Transient();
    }

    function test_Increment() public {
        transient.increment();
        assertEq(transient.number_transient(), 1);
    }

    function test_Increment_Multiple() public {
        transient.increment();
        transient.increment();
        transient.increment();
        assertEq(transient.number_transient(), 3);
    }
}
