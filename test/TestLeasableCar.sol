pragma solidity ^0.4.8;

import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";
import "../contracts/LeasableCar.sol";
// import "../contracts/LeasablesMarketplace.sol";

contract TestLeasableCar {

    function testSetGetPrice() public {
        
        LeasableCar car = new LeasableCar("VIN123", "2018", "S4", "Audi", "Blue");

        car.setPrice(20180501, 3000);
        Assert.equal(car.getPrice(20180501), 3000, "get/setPrice is broken!");

        // car.setPrice(20180502, 3100);
        Assert.equal(car.getPrice(20180502), 0, "get/setPrice is broken!");

        car.setPrice(20180502, 3100);
        Assert.equal(car.getPrice(20180502), 3100, "get/setPrice is broken!");

        // uint[] memory price_dates = car.getAvailablePrices();
        // Assert.equal(price_dates, [20180501, 20180502], "get/setPrice is broken!");

    }
}
