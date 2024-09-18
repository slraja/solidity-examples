pragma solidity >=0.8.2<0.9.0;

//import 
// import "filename";
// import * as symbolname from "filename2";
// import {symb1 as alies, symbol2} from "filename3" ;


// first contract 
contract SimpleContract{

    //units 

    //ether gwei wei
    bool isEqual = (1 ether == 1e18 wei);

    //seconds , minutes, hours , days , weeks 
    //time units
    bool isTime = (1 days == 24 hours);
    
    //special objects

    block.coinbase();
    block.difficulty;

    msg.sender;
    msg.value;

    tx.origin;

    //contract code 
    //state variable
    uint storeData;

    //modifier is a conditional
    modifier onlyData(){
        require(storeData >= 0);
        _;
    }

    //function
    function set (uint x) public {
        storeData = x;
    }


    //event
    event Sent(address from, address to, uint storeData);


    //function 

    function calcs(uint a, uint b) public pure  
    returns (uint sum, uint prod){
        sum = a + b ;
        prod = a * b ;
    }

    function check() public   {

        if(storeData>1){
            storeData=2;
        }
    }    


    //Artihmetic operators + - * / % ++ --
    //Logical operators ! && || == !=
    //Bitwise operators | & ^(xor) ~(not)  >> << 
    //Assignment operators = += -= *= /= %= |= &= 
    //Others ? . [] delete =>  new this super uintx(25)

    //Conditionals - if loop, do  while , while , for 

    //other key words - revert assert require 

function globalVars(uint a, uint b) external view returns (address, uint, uint) {
    address sender = msg.sender;
    uint timestamp = block.timestamp;
    uint blockNum = block.number; 
    return (sender, timestamp, blockNum); 
} 

    function destructingAssigments()
        public
        returns (
            uint,
            bool,
            uint,
            uint,
            uint
        )
    {
        (uint i, bool b, uint j) = returnMany();

        // Values can be left out.
        (uint x, , uint y) = (4, 5, 6);

        return (i, b, j, x, y);
    }


}
