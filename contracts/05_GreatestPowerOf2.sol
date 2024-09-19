// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Level4Template {
    function solution(uint256 number) external pure returns (uint256) {
        // Special case: If the number is 0, return 0 (though in the prompt, numbers start from 2^0)
        if (number == 0) {
            return 0;
        }
        
        // Initialize a variable to store the result, which will be the highest power of 2
        uint256 result = 1;

        // Keep shifting the input number to the right until we get a single bit
        while (number > 1) {
            number = number >> 1;
            result = result << 1; // Every time we shift, we track the corresponding power of 2
        }

        return result; // This will now contain the greatest power of 2 less than or equal to the original input
    }
}
