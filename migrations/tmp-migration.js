const UserFunctions = artifacts.require("./UserFunctions.sol");

async function doDeploy(deployer, network) {
  await deployer.deploy(UserFunctions);
}

module.exports = (deployer, network) => {
  deployer.then(async () => {
      await doDeploy(deployer, network);
  });
};
