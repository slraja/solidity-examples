// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Level3Template {
    function solution(bytes memory packed) external pure returns (uint16 a, bool b, bytes6 c) {
        require(packed.length == 9, "Invalid packed length");

        assembly {
            // Load the first 32 bytes of `packed`, skipping the length word
            let packedData := add(packed, 32)

            // Extract `a` (uint16) from the first two bytes
            a := shr(240, mload(packedData))

            // Extract `b` (bool) from the third byte
            b := eq(shr(248, mload(add(packedData, 2))), 1)

            // Extract `c` (bytes6) from the next 6 bytes directly
            let cData := mload(add(packedData, 3)) // Load 32 bytes starting from byte 3
            //c := and(cData, 0xffffffffffff000000000000000000000000000000000000000000000000) // Mask the first 6 bytes
            c := shr(208, cData) // Shift by 192 bits to align correctly
            c := shl(208, c) // Shift by 192 bits to align correctly
        }
    }
}
