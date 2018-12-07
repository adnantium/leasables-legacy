pragma solidity ^0.4.24;

import "./Leasable.sol";
import "./LeaseContract.sol";



// Digital representation of a specific Car in the real world. Each 
// car can (should) only have one "avatar" on the chain
// 
// It manages and coordinates its own individual lease contracts with 
// drivers based on requirements provided by its owner(s)
// 
// The contract creator can specifcy:
//  * start and enddate of the time range that this car is available
//  * minimum allowed lease period e.g. 10 days
//  * The "home" street address that the car's pickup and return must be done within
//  * Max distance from "home" Default 5 miles
//  * 
// The contracts between the car and driver are created thru this contract. The contract 
//  assures no conflicts in time ranges


contract LeasableCar is Leasable {

    string public VIN;
    string public year;
    string public model;
    string public manufacturer;
    string public color;

    string[] public photos;

    address[] public lease_contracts;

    // dict of yyyyddmm -> the price for that day
    mapping (uint => uint) date_prices;

    // the list dates that any prices have been defined for
    // does not mean the car is available, just that we have a price
    uint[] dates_priced;


    constructor(
            string _VIN,
            string _year,
            string _model,
            string _manufacturer,
            string _color)
        public
    {
        // TODO: cehck validity of each field
        VIN = _VIN;
        year = _year;
        model = _model;
        manufacturer = _manufacturer;
        color = _color;
    }

    // function getDesc() public view returns(string) {
    //     string desc = new string(car_details.VIN + " " + car_details.model);
    //     return desc;
    // }

    function getVIN() public view returns (string) {
        return VIN;
    }

    function getModel() public view returns (string) {
        return model;
    }

    function getDetails() public view returns (
        string,
        string,
        string,
        string,
        string) 
    {
        return (
            VIN, year, model, manufacturer, color
        );
    }

    function addPhoto(string image_url)
        public
        onlyOwner
        returns (bool)
    {
        photos.push(image_url);
    }


    // cant return string arrays!?
    //      LeasableCar.sol:96:18: TypeError: This type is only supported in the new 
    //      experimental ABI encoder. Use "pragma experimental ABIEncoderV2;" ...
    //      returns (string[])

    // function getPhotos()
    //     public
    //     onlyOwner
    //     returns (string[])
    // {
    //     return photos;
    // }

    // TODO: function clearPhotos()

    function getLeaseContracts() public view returns (address[]) {
        return lease_contracts;
    }


    /** @dev gets list of dates that owner has defined prices for. This will return all the known dates, even if the car is not available (already leased) for that day
      * @return list of dates that the car has prices defined for
      */
    function getDatesPriced()
        public
        view
        returns (uint[])
    {
        return dates_priced;
    }

    /** @dev Sets the lease price for a specific yyyymmdd.
      * @param _yyyymmdd The day
      * @param _price The price (in cents) for that day
      * @return success true if everyting went ok
      */
    function setPrice (
        uint _yyyymmdd,
        // string _end_yyyymmdd,
        uint _price)
        public
        onlyOwner
        returns (bool)
    {
        date_prices[_yyyymmdd] = _price;
        // TODO: check if the date is already in the available list
        dates_priced.push(_yyyymmdd);
        return true;
    }

    function getPrice(uint _yyyymmdd)
        public
        view
        returns (uint)
    {
        // require(is_valid_date(_yyyymmdd));
        return date_prices[_yyyymmdd];
    }


    // function getPrices()
    //     public
    //     returns (string[], uint[])
    // {
    //     return (daily_price)
    // }

    function validate_date_format (
        uint _yyyymmdd)
        public
        pure
        returns (bool)
    {
        // TODO: do the validation
        // will hope for best in meantime
        return true;
    }

    function approve_driver (
        address _driver)
        public
        returns (bool)
    {
        // TODO:
        // check that driver meets the requirements for leasing this car.
        // will involve:
        //  * drover has a valid association with some external identity mgmt protocol e.g. uport
        //  * driver has a deposit in escrow (now or later?)
        //  * 

        // will hope for best in meantime
        return true;
    }

    function check_dates_are_available (
        uint _start_yyyymmdd,
        uint _end_yyyymmdd)
        public
        returns (bool)
    {
        // TODO:
        // check that driver meets the requirements for leasing this car.
        // will involve:
        //  * drover has a valid association with some external identity mgmt protocol e.g. uport
        //  * driver has a deposit in escrow (now or later?)
        //  * 

        // will hope for best in meantime
        return true;
    }



    // function requestQuote (
    //     uint _start_yyyymmdd,
    //     uint _end_yyyymmdd)
    //     public 
    //     returns (address)
    // {
    //     address driver = msg.sender;

    //     // TODO:
    //     //  confirm date ranges are available
    //     //  
    //     // calculate a lease cost for the period using:
    //     //      * expected price change within the time period
    //     //          need start + end price
    //     //      * money cost
    //     //      * insurance cost daily e.g. $4
    //     //      * car's required profit margin
    //     //      * available maintance budget 
    //     //      * incentives for driver
    //     //      * fully visible fees

    // }

    // called by the wanna be driver
    function requestContractDraft (
        uint _start_yyyymmdd,
        uint _end_yyyymmdd)
        public
        returns (LeaseContract lease_contract)
    {
        address driver = msg.sender;
        address car = address(this);

        // TODO: confirm if this driver is cool enough to get a 
        //  contract for this nice car
        require(approve_driver(driver), "Driver is not approved to lease this vehicle");

        // TODO: Check:
        //  start/end dates are valid.
        require(validate_date_format(_start_yyyymmdd), "start date is invalid!");
        require(validate_date_format(_end_yyyymmdd), "end date is invalid!");
         
        //  Need to look at all existing LeaseContracts for this car
        //  Ensure the timeframe in this LeaseContract does not overlap
        //  with any previously created LeaseContract contracts
        require(check_dates_are_available(_start_yyyymmdd, _end_yyyymmdd), "Lease term is not available!");

        // TODO: check driver is Drivest approved. How?
        //      SHould test: driver is in good standing
        // TODO: check driver meets other spefici requirements unique to this car
        // 

        LeaseContract new_leasecontract = 
            new LeaseContract(car, driver, _start_yyyymmdd, _end_yyyymmdd);
        lease_contracts.push(new_leasecontract);
        return new_leasecontract;

    }

    // function selfDestruct() public {
    //     im_dead = true;
    // }



}
