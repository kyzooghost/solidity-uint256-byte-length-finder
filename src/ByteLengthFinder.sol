pragma solidity 0.8.28;
contract ByteLengthFinder {
    function getUint256ByteLengthWithBinarySearch(uint256 x) external returns (uint256) {
        assembly {
            if iszero(x) {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            // Starting index of byte section we will check, 0=MSB, 31=LSB
            // We start from MSB, and so we greedily check the most significant byte section that we have not ruled out
            let sectionStart := 0
            // Length in bits of section we will check
            let sectionLength := 128
            for {
            } gt(sectionLength, 7) {
                // Halve sectionLength with each round
                sectionLength := shr(1, sectionLength)
            } {
                let section := shr(sub(256, add(sectionLength, sectionStart)), x)
                // This byte section is 0 -> in next round, byte section starts where the current round's section ended
                if iszero(section) {
                    sectionStart := add(sectionStart, sectionLength)
                    continue
                }
                // This byte section is not-zero -> in next round, byte section starts where current round's section started
            }
            mstore(0x00, div(sub(256, sectionStart), 8))
            return(0x00, 0x20)
        }
    }

    function getUint256ByteLengthWithLinearSearch(uint256 x) external returns (uint256) {
        assembly {
            let i := 0
            for {
            } lt(i, 32) {
                i := add(i, 1)
            } {
                if iszero(and(shr(sub(248, mul(i, 8)), x), 0xff)) {
                    continue
                }
                break
            }
            mstore(0x00, sub(32, i))
            return(0x00, 0x20)
        }
    }
}