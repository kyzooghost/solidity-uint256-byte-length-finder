pragma solidity ^0.8.28;
import {Test, console, Vm} from "forge-std/Test.sol";
import {ByteLengthFinder} from "../src/ByteLengthFinder.sol";

contract ByteLengthFinderTest is Test {
    ByteLengthFinder public c;

    function setUp() public {
        c = new ByteLengthFinder();
    }

    function test_AnonymonusEventWithoutData() public {
        assertEq(c.getUint256ByteLengthWithBinarySearch(1), 1);
    }
}