// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "./Context.sol";

contract ContextTest is Test {
    Context public context;

    // Set up the testing environment
    function setUp() public {
        context = new Context();
    }

    uint256 readNumber;
    address readAddress;

    // Tests setting context and making an external call
    function test_set_call_and_check_values(uint256 number, address addr)
        public
    {
        // Asks the Context to set the values and make an external call to the fallback function defined below
        context.setAndCall(number, addr, address(this));

        // Verifies that the values match what was set
        assertEq(readNumber, number);
        assertEq(readAddress, addr);

        // Verifies that the context was reset after the call
        assertEq(context.getNumber(), 0);
        assertEq(context.getAddress(), address(0));
    }

    // Fallback function to handle the external call
    fallback() external {
        address caller = msg.sender;

        (, bytes memory readNumberBytes) =
            caller.call(abi.encodeWithSignature("getNumber()"));
        (, bytes memory readAddressBytes) =
            caller.call(abi.encodeWithSignature("getAddress()"));

        // Decodes and stores the values from the external call
        readNumber = abi.decode(readNumberBytes, (uint256));
        readAddress = abi.decode(readAddressBytes, (address));
    }
}
