let Auction = artifacts.require('./Auction.sol');

contract('Auction Testing', accounts => {

	let auction = {};

	before(async () => {
		auction = await Auction.new(10, accounts[1], {from: accounts[0]});
	});

	it('Should be able to create a nation core and receive the create nation event', function() {
		return auction.createNation("CORE HASH/JSON STRINGIFY")
			.then(function(txReceipt) {
				assert.equal(txReceipt.logs.length, 1, "There should have been one event emitted");
				assert.equal(txReceipt.logs[0].event, "NationCreated", "Event emitted should have been NationCreated");
			})
	});

});
