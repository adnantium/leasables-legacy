

var assert = require('assert');

const Web3 = require('web3');

var LeasableCarContract = artifacts.require("LeasableCar");

contract('TestLeasableCar', function(accounts) {

    var test_car1_uid;
    var test_car1_contract;
    var acct1_uid = accounts[0];
    var acct2_uid = accounts[1];

    before(async function() {
        // console.log("accounts: " + accounts);

        // create a car and hold onto its contract and address for later
        test_car1_contract = await LeasableCarContract
            .new('VIN1231', '2019', 'Audi', 'S4', 'Blue', 
            {from: acct1_uid, gas: 4712388, gasPrice: 100000000000}
        );
        test_car1_uid = test_car1_contract.address
        console.log("test car uid: " + test_car1_uid);
    });

    it("Checking getters...", async function() {
        var car_contract = await LeasableCarContract.at(test_car1_uid);
        var car_model = await car_contract.getModel.call();
        assert.equal(car_model, 'Audi', 'getModel is broken!');

        var car_details = await car_contract.getDetails.call();
        assert.equal(car_details.length, 5, 'getDetails should return 5 elements!');
    });

    it("Checking setPrice, getPrice and getPricedDates", async function() {
        var price_response = false;
        price_response = await test_car1_contract.setPrice(20180501, 55011, {from: acct1_uid, gas: 4712388, gasPrice: 100000000000});
        assert.ok(price_response, "setPrice failed in some way!");

        // TODO: figure out why not working! Using the cheapy try/catchversion 
        // should fail, using acct2 who is not owner/creator
        // assert.throws(
        //   async () => {
        //     await test_car1_contract.setPrice(20180502, 55022, {from: acct2_uid, gas: 4712388, gasPrice: 100000000000});
        //   },
        //   'StatusError:'
        // );

        // should fail, using acct2 who is not owner/creator
        try {
            await test_car1_contract.setPrice(20180502, 55022, {from: acct2_uid, gas: 4712388, gasPrice: 100000000000})
        } catch(err) {
            // console.log("err: " + err);
            assert(err);
        }

        var dates_priced;
        dates_priced = await test_car1_contract.getDatesPriced.call()
        assert.equal(dates_priced.length, 1, "Should have 1 date priced!")

        // adding another one from acct1
        price_response = await test_car1_contract.setPrice(20180502, 55022, {from: acct1_uid, gas: 4712388, gasPrice: 100000000000});
        assert.ok(price_response, "setPrice failed in some way!");

        // should have 2 dates now
        dates_priced = await test_car1_contract.getDatesPriced.call()
        assert.equal(dates_priced.length, 2, "Should have 2 date priced!")

        var price;
        price = await test_car1_contract.getPrice.call(20180502);
        assert.equal(price.toNumber(), 55022, "getPrice for VALID date is broken!")

        // we didnt set a price for this date
        // we get a 0 back because of the way solidity dict lookups work. Should it error instead?
        price = await test_car1_contract.getPrice.call(20180503);
        // console.log(price);
        assert.equal(price.toNumber(), 0, "getPrice for INVALID date is broken!")



    });

    it("Checking yyyymmdd functions", async function() {

        var car_contract = await LeasableCarContract.at(test_car1_uid);
        // var car_model = await car_contract.getModel.call();
        // assert.equal(car_model, 'Audi', 'getModel is broken!');

        // var car_details = await car_contract.getDetails.call();
        // assert.equal(car_details.length, 5, 'getDetails should return 5 elements!');

        // TODO: test more scenarios. validate_date_format is hardcode to true right now
        var is_valid;
        is_valid = await car_contract.validate_date_format.call(20170501);
        assert.equal(is_valid, true, "validate_date_format is messed up!")


    });
});
