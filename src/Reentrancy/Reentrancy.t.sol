// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reentrancy} from "src/Reentrancy/Reentrancy.sol";

contract ReentrancyTest is Test {
    Reentrancy r;
    Callback c;

    function setUp() public {
        r = new Reentrancy();
        c = new Callback(r);
    }

    function test_dummy_call() public {
        c.setCallbacks(0);
        r.callback(
            address(c),
            abi.encodeWithSelector(ICallback.processCallbacks.selector)
        );

        assertEq(c.remainingCallbacks(), 0);
    }

    function test_single_call() public {
        c.setCallbacks(1);
        r.callback(
            address(c),
            abi.encodeWithSelector(ICallback.processCallbacks.selector)
        );

        // It should remain at 1 because it refuses to call back
        // due to the reentrancy
        assertEq(c.remainingCallbacks(), 1);
    }
}

interface ICallback {
    function processCallbacks() external;
    function dummyCallback() external;
}

contract Callback {
    Reentrancy reentrancy;

    constructor(Reentrancy r) public {
        r = reentrancy;
    }

    uint256 public remainingCallbacks = 0;

    function setCallbacks(uint256 count) public {
        remainingCallbacks = count;
    }

    function dummyCallback() public {
        // do nothing
    }

    function processCallbacks() public {
        if (remainingCallbacks > 0) {
            remainingCallbacks--;
            reentrancy.callback(
                address(this),
                abi.encodeWithSelector(ICallback.processCallbacks.selector)
            );
        } else {
            // do nothing
            // reentrancy.callback(address(this), abi.encodeWithSelector(ICallback.dummyCallback.selector));
        }
    }
}
