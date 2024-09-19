// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Level5Template {
    function solution(int256 a, int256 b) external pure returns (int256) {
        assembly {
            // Compute half of a and half of b using signed division
            let halfA := sdiv(a, 2)
            let halfB := sdiv(b, 2)

            // Compute carry using signed modulo (smod)
            let carryA := smod(a, 2)    // a % 2 (signed)
            let carryB := smod(b, 2)    // b % 2 (signed)
            
            // Calculate carry: (a % 2 + b % 2 + 1) / 2
            let carry := add(carryA, carryB)  // a % 2 + b % 2
            carry := add(carry, 1)            // a % 2 + b % 2 + 1
            carry := sdiv(carry, 2)           // (a % 2 + b % 2 + 1) / 2

            // Safely compute the result: halfA + halfB + carry
            let result := add(add(halfA, halfB), carry)

            // Store the result in memory and return it
            let free_mem_ptr := mload(0x40)
            mstore(free_mem_ptr, result)
            return(free_mem_ptr, 32)
        }
    }
}

