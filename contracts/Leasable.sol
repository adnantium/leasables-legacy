pragma solidity ^0.4.24;


// Leasable: An object that can be offered for rent by owners
//  and can be borrowed by others
//  by buying this leasable object's tokens. See LeasePeriod.sol
//
// attributes:
//  owner
//  unique external id
//  desc
//


import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Leasable is Ownable {

    string public object_name = "default name";
    string public description;
    string public test_str = "TESTING";

    // constructor() public {
    // }

    function setName(string _name) public onlyOwner {
        object_name = _name;
    }

    function getName() public view returns (string) {
        return object_name;
    }

}
