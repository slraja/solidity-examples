pragma solidity 0.8.22;
contract L {
    function solution() external pure returns (uint8) {
        assembly {
            mstore(0x80, 42) // Store the value 42 in memory
            return(0x80, 32) // Return 32 bytes starting from 0x80
        }
    }
}