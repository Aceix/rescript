const SimpleStorage = artifacts.require("./Users.sol");
// const SimpleStorage = artifacts.require("./UserFunctions.sol");
// const SimpleStorage = artifacts.require("./SchoolFunctions.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
};
