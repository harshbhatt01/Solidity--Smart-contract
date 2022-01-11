pragma solidity 0.7.5;

contract profile{

    struct Men{
        string name;
        address id;
    }

    Men[] men;


    mapping(address => string) person;

    function setPerson(string memory _name, address _id) public {
        Men memory _men = Men(_name, _id);
        men.push(_men);
    }

    function getPerson(uint _index) public view returns(string memory, address){
        return(men[_index].name, men[_index].id);
    }

    
}
