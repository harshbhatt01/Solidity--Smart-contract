pragma solidity 0.7.5;

// ownable consist of functions that are static and we don't change thwm oftenly

contract ownable{

    address  internal owner;

    // modifiers are used for the checks that are required in contract multiple times and if we input this checks every time it will add more space instead if we use modifier, it will be identified by adding the name of the modifier in function header and will check for the checks that are to be done which are specified in the modifiers
    modifier onlyOwner{
        // check if msg sender is the owner
        require(msg.sender == owner);
        _;
    }

    //just to check if the msg sender is the owner
    constructor (){
        owner = msg.sender;
    }

}
