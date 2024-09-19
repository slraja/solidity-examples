// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Level4Template {
    function solution(uint256 numbe) external pure returns (uint256) {
        assembly {
            // Load the input `number` value from memory
            let num := numbe

            // Special case: If the input is 0, the result should be 0 (although the input is said to be >= 2^0)
            if iszero(num) {
                mstore(0x0, 0)
                return(0x0, 32)
            }
            
            // Create a variable to store the result
            let result := num

            // Perform a series of right shifts to find the highest set bit
            // This step compresses the number down to the highest set bit
            result := or(result, shr(1, result))
            result := or(result, shr(2, result))
            result := or(result, shr(4, result))
            result := or(result, shr(8, result))
            result := or(result, shr(16, result))
            result := or(result, shr(32, result))
            result := or(result, shr(64, result))
            result := or(result, shr(128, result))

            // Reduce the result to the greatest power of 2
            result := add(result, 1)
            result := shr(1, result)

            // Store the result and return it
            mstore(0x0, result)
            return(0x0, 32)
        }
    }
}
