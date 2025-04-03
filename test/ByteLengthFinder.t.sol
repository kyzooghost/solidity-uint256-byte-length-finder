pragma solidity ^0.8.28;

import { Test } from "forge-std/Test.sol";
import { ByteLengthFinder } from "../src/ByteLengthFinder.sol";

contract ByteLengthFinderTest is Test {
    ByteLengthFinder public c;

    function setUp() public {
        c = new ByteLengthFinder();
    }

    function test_zero() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(0), 0);
    }

    function test_one() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1), 1);
    }

    function test_1000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1000), 2);
    }

    function test_9000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(9000), 2);
    }

    function test_maxUint256() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(type(uint256).max), 32);
    }
}