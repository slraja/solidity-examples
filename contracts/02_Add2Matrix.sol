// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Level1Template  {


    function solution(uint256[2][3] calldata x, uint256[2][3] calldata y) external pure returns (uint256[2][3] memory finalArray) {

        // Iterate through both matrices and add corresponding elements
        for (uint256 i = 0; i < x.length; i++) {
            for (uint256 j = 0; j < x[i].length; j++) {
                finalArray[i][j] = x[i][j] + y[i][j];  // Add corresponding elements
            }
        }

        // Return the resulting array
        return finalArray;
    }
}
