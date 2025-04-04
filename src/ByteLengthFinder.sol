pragma solidity 0.8.28;
contract ByteLengthFinder {
    function getUint256ByteLengthWithBinarySearch(uint256 x) external returns (uint256) {
        assembly {
            if iszero(x) {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            // Starting index of bit section we will check, 0=MSB, 255=LSB
            // We start from MSB, and so we greedily check the most significant bit section that we have not ruled out
            let sectionStart := 0
            // Bit length of section we will check
            let sectionLength := 128
            for {
            // Stop when bit section < 1 byte
            } gt(sectionLength, 7) {
                // Halve sectionLength with each round
                sectionLength := shr(1, sectionLength)
            } {
                // No need to left shift because we greedily check the most significant bits. So any bytes to the left of section will be 0
                // Right shift 'x' until desired section occupies least significant bits
                let section := shr(sub(256, add(sectionLength, sectionStart)), x)
                // Current section is 0 -> in next round, section starts where the current section ended
                if iszero(section) {
                    sectionStart := add(sectionStart, sectionLength)
                    continue
                }
                // Current section is not-zero -> in next round, section start does not change
            }
            // Divide by 8 to convert from bits to bytes
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