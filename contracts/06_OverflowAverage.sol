// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;




contract Level5Template {
    function solution(int256 a, int256 b) external pure returns (int256) {
        // To prevent overflow, we compute the average in a safe way
        // Calculate the half values to avoid overflow
        int256 halfA = a / 2;
        int256 halfB = b / 2;

        // If both a and b are either odd, we add 1 to the result to round up
        int256 carry = (a % 2 + b % 2 + 1) / 2;

        // Safely compute the result
        return halfA + halfB + carry;
    }
}
