
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Level1Template  {

    function solution(uint256[2][3] calldata x, uint256[2][3] calldata y) external pure returns (uint256[2][3] memory finalArray) {

        uint256 n = x.length;   // Number of rows
        uint256 m = x[0].length; // Number of columns (assumed to be the same for all rows)

        // Total elements in the flattened array (n rows * m columns)
        uint256 totalElements = n * m;

        // Start with the free memory pointer and allocate memory for the result array
        assembly {
            // Load the current free memory pointer
            finalArray := mload(0x40)

            // Store the number of rows (n) at the start of the memory location (32 bytes for length)
            mstore(finalArray, n)

            // Calculate the start of the data section (after the number of rows)
            let dataPtr := add(finalArray, 0x20)

            // Initialize element index for tracking where to store in memory
            let elementIndex := 0

            // Iterate through rows and columns
            for { let i := 0 } lt(i, n) { i := add(i, 1) } {
                // Load the row pointers for both x and y arrays
                let xRowPtr := calldataload(add(x, mul(i, 0x20)))
                let yRowPtr := calldataload(add(y, mul(i, 0x20)))

                // Store the number of columns (m) for each row in memory
                mstore(add(dataPtr, mul(elementIndex, 0x20)), m)
                elementIndex := add(elementIndex, 1)

                // Iterate through the columns
                for { let j := 0 } lt(j, m) { j := add(j, 1) } {
                    // Load the elements from x[i][j] and y[i][j]
                    let xElem := calldataload(add(xRowPtr, mul(j, 0x20)))  // x[i][j]
                    let yElem := calldataload(add(yRowPtr, mul(j, 0x20)))  // y[i][j]

                    // Add x[i][j] + y[i][j] and store the result in memory
                    mstore(add(dataPtr, mul(elementIndex, 0x20)), add(xElem, yElem))

                    // Move to the next element
                    elementIndex := add(elementIndex, 1)
                }
            }

            // Update the free memory pointer after the array has been written
            let totalSize := mul(add(totalElements, 1), 0x20)  // Total size: elements + length (32 bytes each)
            mstore(0x40, add(finalArray, totalSize))  // Update free memory pointer to the next available space
        }

        // Return the final result array
        return finalArray;
    }
}
