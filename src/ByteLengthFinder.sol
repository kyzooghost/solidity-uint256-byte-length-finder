pragma solidity 0.8.28;

import { console } from "forge-std/console.sol";

contract ByteLengthFinder {
    function getUint256ByteLengthWithBinarySearch(uint256 x) external returns (uint256) {
        assembly {
            if iszero(x) {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            log1(0x00, 0, x)
            // Starting index of byte section we will check, 0=MSB, 31=LSB
            // We start from MSB, and so we greedily check the most significant byte section that we have not ruled out
            let sectionStart := 0
            // Length in bytes of section we will check
            let sectionLength := 16
            for {
            // TODO - Check this ending condition
            } gt(sectionLength, 0) {
                // Halve sectionLength with each round
                sectionLength := shr(1, sectionLength)
            } {
                let section := shl(mul(8, sectionStart), x)
                log1(0x00, 0, section)
                section := shr(mul(8, sectionStart), section)
                log1(0x00, 0, section)
                section := shr(mul(8, sectionLength), section)
                log1(0x00, 0, section)
                // This byte section is 0 -> in next round, byte section starts where the current round's section ended
                
                log3(0x00, 0, sectionStart, sectionLength, section)
                if iszero(section) {
                    sectionStart := add(sectionStart, sectionLength)
                    continue
                }
                // This byte section is not-zero -> in next round, byte section starts where current round's section started
            }
            mstore(0x00, sub(32, sectionStart))
            return(0x00, 0x20)
        }
    }
}

// R1
// 0000-0000-0000-0000-0000-0000-0000-0XXX
// sS = 0, sL = 16

// R2
// 0000-0000-0000-0XXX
// sS = 16, sL = 8

// R3
// 0000-0XXX
// sS = 24, sL = 4

// R4
// 0XXX
// sS = 28, sL = 2

    // │   ├─  emit topic 0: 0x000000000000000000000000000000000000000000000000000000000000001c
    // │   │        topic 1: 0x0000000000000000000000000000000000000000000000000000000000000002
    // │   │        topic 2: 0x0000000000000000000000000000000000000000000000000000000000000000