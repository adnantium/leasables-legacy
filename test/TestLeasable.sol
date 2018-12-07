pragma solidity ^0.4.8;

import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";
import "../contracts/Leasable.sol";
// import "../contracts/LeasablesMarketplace.sol";

contract TestLeasable {

    function testSetName() public {
        Leasable lsbl = new Leasable();
        string memory test_name = "testing name 1";
        lsbl.setName(test_name);
        string memory name = lsbl.getName();
        Assert.equal(name, test_name, "getName is broken!");
    }
}
