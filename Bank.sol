pragma solidity 0.7.5;

//importing smart contract ownable here
import "./ownable.sol";


    // interface created to communicate with external function of government contract.
    interface GovernmentInterface{
        function addTransaction(address _from, address _to, uint _amount) external;
    }

contract HelloByHarsh is ownable{


    // instance for the interface and the address of the government contract's address, because it is deployed from the another address.
    GovernmentInterface governmentInstance = GovernmentInterface(0xddaAd340b0f1Ef65169Ae5E41A8b10776a75482d);

    //mapping keytyape=> datatype
    mapping(address => uint) bal;

    
    // event for adding the balance into the account
    event depositDone(uint amount, address depositedTo);

    // event for transferring balance
    event transferDone(uint amount, address towhom);

    
    //adding balance to address or changing value of the address
    function deposit() public payable returns(uint){

        bal[msg.sender] += msg.value;

        //emitting the event balanceadded to notify the frontend that balance is added
        emit depositDone(msg.value, msg.sender);

        
        return bal[msg.sender];
    }

    // retriving the data
    function getbalance() public view returns(uint){
        return bal[msg.sender];
    }

    // this public will call all the function from private and will run
    function transfer(address receip, uint amount) public {

        //check if the balance of msg sender is greater than or equal to the amount he is sending
        require(bal[msg.sender] >= amount);

        //check if the msg sender is also not the receipeint
        require(msg.sender != receip);

        // check the previous balance
        uint prevbalofSender = bal[msg.sender];

        _transfer(msg.sender, receip, amount);// calls the private function and passes the data from it

        //emitting the event balanceadded to notify the frontend that balance is transfered
        emit transferDone(amount, receip);


        // instance fired and the external function here calls the actual function of the transfer function i.e (msg.sender, receip, amount) 
        governmentInstance.addTransaction(msg.sender, receip, amount);

        // check the balance after transfer happens that it should be equal to previous bal minus the amount transfered
        assert(bal[msg.sender] == prevbalofSender - amount);
    }

    //private function
    function _transfer(address from, address to, uint amount) private{
        bal[from] -= amount;
        bal[to] += amount;
    }
}
