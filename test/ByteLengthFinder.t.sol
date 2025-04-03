pragma solidity ^0.8.28;

import { Test } from "forge-std/Test.sol";
import { ByteLengthFinder } from "../src/ByteLengthFinder.sol";

contract ByteLengthFinderTest is Test {
    ByteLengthFinder public c;

    function setUp() public {
        c = new ByteLengthFinder();
    }

    // function test_zero() public {
    //     assertEq(c.getUint256ByteLengthWithBinarySearch(0), 0);
    // }

    function test_1() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1), 1);
    }

    function test_1Ref() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(1), 1);
    }

    function test_1000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1000), 2);
    }

    function test_1000Ref() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(1000), 2);
    }

    function test_9000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(9000), 2);
    }

    function test_9000Ref() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(9000), 2);
    }

    function test_maxUint256() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(type(uint256).max), 32);
    }

    function test_maxUint256Ref() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(type(uint256).max), 32);
    }

    function test_9489014812984912() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(9489014812984912), 7);
    }

    function test_9489014812984912Ref() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(9489014812984912), 7);
    }
}
