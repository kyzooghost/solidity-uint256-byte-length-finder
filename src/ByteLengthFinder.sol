pragma solidity 0.8.28;

contract ByteLengthFinder {
    function getUint256ByteLengthWithBinarySearch(uint256 x) external pure returns (uint256) {
        assembly {
            if iszero(x) {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            // Length in bytes of section we will check
            let sectionLength := 16
            // Starting index of section we will check, 0=MSB, 31=LSB
            // We start from MSB, and so we greedily check the most significant byte section that we have not ruled out
            let sectionStart := 0
            for {
            // TODO - Check this ending condition
            } gt(sectionLength, 0) {
                // Halve sectionLength with each round
                sectionLength := shr(1, sectionLength)
            } {
                let section := shl(sectionStart, x)
                section := shr(sectionLength, section)
                // This byte section is 0 -> in next round, byte section starts where the current round's section ended
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