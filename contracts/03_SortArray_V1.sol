// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Level2Template  {
        
    function solution(uint256[10] calldata unsortedArray) external returns (uint256[10] memory sortedArray){

        for (uint256 i = 0; i < 10; i++) {
            sortedArray[i] = unsortedArray[i];
        }

        // Implementing Bubble Sort for a fixed-size array
        for (uint256 i = 0; i < 10; i++) {
            for (uint256 j = 0; j < 9 - i; j++) {
                // Inline assembly for more efficient access and swapping
                assembly {
                    // Load the two elements that need to be compared
                    let a := mload(add(sortedArray, mul(j, 0x20)))
                    let b := mload(add(sortedArray, mul(add(j, 1), 0x20)))

                    // If a > b, swap them
                    if gt(a, b) {
                        // Swap a and b in memory
                        mstore(add(sortedArray, mul(j, 0x20)), b)
                        mstore(add(sortedArray, mul(add(j, 1), 0x20)), a)
                    }
                }
            }
        } 

        return sortedArray;
    }
}
