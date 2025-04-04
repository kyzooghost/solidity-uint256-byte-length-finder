pragma solidity ^0.8.28;

import { Test } from "forge-std/Test.sol";
import { ByteLengthFinder } from "../src/ByteLengthFinder.sol";

contract ByteLengthFinderTest is Test {
    ByteLengthFinder public c;

    function setUp() public {
        c = new ByteLengthFinder();
    }

    function test_binary_0() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(0), 0);
    }
    
    function test_linear_0() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(0), 0);
    }

    function test_binary_1() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1), 1);
    }

    function test_linear_1() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(1), 1);
    }

    function test_binary_10() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(10), 1);
    }

    function test_linear_10() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(10), 1);
    }

    function test_binary_100() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(100), 1);
    }

    function test_linear_100() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(100), 1);
    }

    function test_binary_1000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1000), 2);
    }

    function test_linear_1000() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(1000), 2);
    }

    function test_binary_10000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(10000), 2);
    }

    function test_linear_10000() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(10000), 2);
    }

    function test_binary_100000() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(100000), 3);
    }

    function test_linear_100000() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(100000), 3);
    }

    function test_binary_10_pow_18() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(10**18), 8);
    }

    function test_linear_10_pow_18() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(10**18), 8);
    }

    function test_binary_10_pow_40() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(10**40), 17);
    }

    function test_linear_10_pow_40() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(10**40), 17);
    }

    function test_binary_maxUint256() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(type(uint256).max), 32);
    }

    function test_linear_maxUint256() public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(type(uint256).max), 32);
    }

    function testFuzz_equivalenceForLinearAndBinaryImplementations(uint256 x) public {
        assertEq(c.getUint256ByteLengthWithLinearSearch(x), c.getUint256ByteLengthWithBinarySearch(x));
    }
}