const StringUtils = artifacts.require("../libraries/StringUtils.sol");
const Users = artifacts.require("./Users.sol");
const SchoolFunctions = artifacts.require("./SchoolFunctions.sol");
const UserFunctions = artifacts.require("./UserFunctions.sol");
// const {Users, SchoolFunctions, UserFunctions} = artifacts.require("./Application.sol");


async function doDeploy(deployer, network) {
  await deployer.deploy(StringUtils);
  await deployer.link(StringUtils, Users);
  await deployer.deploy(Users);
  await deployer.deploy(SchoolFunctions);
  // await deployer.deploy(UserFunctions);
}

module.exports = (deployer, network) => {
  deployer.then(async () => {
      await doDeploy(deployer, network);
  });
};
