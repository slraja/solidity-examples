// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Define an abstract contract
abstract contract AbstractContract {
    // Abstract function to be implemented in derived contracts
    function abstractFunction() public virtual returns (string memory);
}

// Define an interface
interface ExampleInterface {
    function interfaceFunction() external returns (bool);
}

// Define a contract
contract SimpleContract is AbstractContract, ExampleInterface {
    // Declare state variables
    address public owner;
    uint public storeData;
    bool public isCompleted;
    mapping(address => uint) public balances;

    // Define an enum
    enum Status { Pending, Shipped, Delivered }

    // Define a struct
    struct Order {
        uint id;
        address buyer;
        Status status;
    }

    // Define an array of structs
    Order[] public orders;

    // Event declaration
    event Sent(address indexed from, address indexed to, uint value);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Fallback function (payable to accept ether)
    fallback() external payable {}

    // Receive function (to accept ether)
    receive() external payable {}

    // Function with modifier
    function set(uint x) public onlyOwner {
        storeData = x;
    }

    // Public function
    function sendEther(address payable _to, uint _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        _to.transfer(_amount);
        emit Sent(msg.sender, _to, _amount);
    }

    // External function implementation from interface
    function interfaceFunction() external override returns (bool) {
        return true;
    }

    // Internal function
    function internalFunction() internal pure returns (uint) {
        return 42;
    }

    // View function (does not modify state)
    function getStoreData() public view returns (uint) {
        return storeData;
    }

    // Pure function (does not modify or read state)
    function calculate(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    // Function using assembly (low-level Solidity)
    function assemblyExample(uint a) public pure returns (uint result) {
        assembly {
            result := add(a, 1)
        }
    }

    // Function with try/catch for error handling
    function tryCatchExample(address _contract) public {
        ExampleInterface example = ExampleInterface(_contract);
        try example.interfaceFunction() {
            // Do something if successful
            isCompleted = true;
        } catch {
            // Handle failure
            isCompleted = false;
        }
    }

    // Function with custom error
    error Unauthorized();

    // Using the error
    function restrictedFunction() public {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
    }

    // Function that implements abstract function from the abstract contract
    function abstractFunction() public pure override returns (string memory) {
        return "Abstract function implemented";
    }

    // A function that performs self-destruct to remove contract from the blockchain
    function destroyContract() public onlyOwner {
        selfdestruct(payable(owner));
    }
}

// Define a library
library MathLibrary {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}

// Define a contract using the library
contract UsingLibrary {
    using MathLibrary for uint;

    function sum(uint a, uint b) public pure returns (uint) {
        return a.add(b);
    }
}

// Define an immutable variable contract
contract ImmutableContract {
    uint public immutable immutableValue;

    constructor(uint _value) {
        immutableValue = _value;
    }
}
