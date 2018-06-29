let Nation = artifacts.require('./OneTimePurchase.sol');

// Test to see if you can create a nation

contract('One Time Purchase Testing', accounts => {

  let OTPContract;
  const price = 1000000000;

  before(async () => {
    OTPContract = await Nation.new(price, "Simple Product", accounts[0], {from: accounts[0]});
  });

  it('Should be able to buy item', function() {
    return OTPContract.buyItem({from: accounts[1], value: price}).then(function(txReceipt) {
      assert.equal(txReceipt.logs.length, 1, "There should have been one event emitted");
      assert.equal(txReceipt.logs[0].event, "ItemPurchased", "Event emitted should have been ItemPurchased");
      return OTPContract.numPurchased();
    }).then(function(number) {
      assert.equal(number, 1, "Should have bought 1 item");
      return OTPContract.checkCustomer(accounts[1]);
    }).then(function(numPurchased) {
      assert.equal(numPurchased, 1, "Should have purchased 1 item");
    })
  });

});
