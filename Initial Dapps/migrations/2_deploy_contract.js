const OTP = artifacts.require('OneTimePurchase');

module.exports = function(deployer) {
  deployer.deploy(OTP, 100, "Description", "0x0");
};
