pragma solidity ^0.4.22;


contract LeaseContract {

    struct Provision {
        string description;
        string content;
    }

    enum LeaseContractStates {
        Draft,
        Created,
        PartiallySigned,
        Approved,
        InProgress,
        Completed,
        Finalized
    }

    // The LeasableCar 
    address public the_car;
    // The Driver
    address public the_driver;
    address public contract_creator;

    Provision[] public provisions;
    LeaseContractStates public contract_state = LeaseContractStates.Draft;
    uint public start_yyyymmdd = 0;
    uint public end_yyyymmdd = 0;

    constructor (
        address _car, 
        address _driver, 
        uint _start_yyyymmdd, 
        uint _end_yyyymmdd) 
        public 
    {

        contract_creator = msg.sender;
        the_car = _car;
        the_driver = _driver;
        start_yyyymmdd = _start_yyyymmdd;
        end_yyyymmdd = _end_yyyymmdd;
    }


    
}
