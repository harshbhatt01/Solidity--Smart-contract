pragma solidity 0.7.5;

contract Government{

    // struct for declaring the variables that would be used in getting the data from another contract
    struct Transaction{
        address from; // msg.sender
        address to; // receip
        uint amount; // amount
        uint Txid;
    }


    // array of transactions 
    Transaction[] _transactionlog;
    
    // external function to add or transfer funds
    function addTransaction(address _from, address _to, uint _amount) external{
        Transaction memory _transaction = Transaction(_from, _to, _amount, _transactionlog.length);
        _transactionlog.push(_transaction);

    }

    // getting the data  
    function getTransaction(uint _index) public view returns(address, address, uint) {
        return(_transactionlog[_index].from, _transactionlog[_index].to, _transactionlog[_index].amount);

    }
    

}
