
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Level1Template  {

    function solution(uint256[2][3] calldata x, uint256[2][3] calldata y) external pure returns (uint256[2][3] memory finalArray) {


        // Start with the free memory pointer and allocate memory for the result array
        assembly {


            // Load the current free memory pointer
            finalArray := mload(0x40)

            // Store the number of rows (n) at the start of the memory location (32 bytes for length)
            mstore(finalArray, 2)

            // Calculate the start of the data section (after the number of rows)
            let dataPtr := add(finalArray, 0x20)

            let xRowPtr := calldataload(x)
            let yRowPtr := calldataload(y)

            for { let i := 0 } lt(i, 6) { i := add(i, 1) } {
                if iszero(mod(i, 3)) {
                    mstore(dataPtr, 3)
                    dataPtr := add(finalArray, 0x20)
                }

                mstore(dataPtr, add(calldataload(xRowPtr), calldataload(yRowPtr)))
                dataPtr := add(dataPtr, 0x20)
                xRowPtr := add(xRowPtr, 0x20)
                yRowPtr := add(yRowPtr, 0x20)
            }

            // Update the free memory pointer after the array has been written
            let totalSize := mul(9, 0x20)  // Total size: elements + length (32 bytes each)
            mstore(0x40, add(finalArray, totalSize))  // Update free memory pointer to the next available space
        }

        // Return the final result array
        return finalArray;
    }
}
