// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Level2Template {
    function solution(uint256[10] calldata unsortedArray) external pure returns (uint256[10] memory sortedArray) {
        assembly {
            // Copy unsortedArray to sortedArray in memory
            for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
                mstore(add(sortedArray, mul(i, 0x20)), calldataload(add(unsortedArray, mul(i, 0x20))))
            }

            // Bubble Sort logic
            let n := 10
            let sorted := 0

            for { } eq(sorted, 0) { } {
                sorted := 1
                let j := 0
                for { } lt(j, sub(n, 1)) { j := add(j, 1) } {
                    let a := mload(add(sortedArray, mul(j, 0x20)))
                    let b := mload(add(sortedArray, mul(add(j, 1), 0x20)))

                    if gt(a, b) {
                        // Swap a and b in memory
                        mstore(add(sortedArray, mul(j, 0x20)), b)
                        mstore(add(sortedArray, mul(add(j, 1), 0x20)), a)
                        sorted := 0 // Indicate that we did a swap, so we need to continue sorting
                    }
                }
                n := sub(n, 1) // Reduce the range of the next bubble sort pass
            }
        }

        return sortedArray;
    }
}
