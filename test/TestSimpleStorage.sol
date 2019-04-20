pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Users.sol";

contract TestSimpleStorage {

  function testItStoresAValue() public {
    Users su = Users(DeployedAddresses.Users());

    uint n = su.createUser(
      "the.accolade@outlook.com",
      "21234567890",
      1,
      "Kwesi",
      "0546912825",
      "Accra",
      0,
      0,
      "",
      ""
    );

    Assert.equal(su.getUserEmail(n), "aceixsmartx@gmailcom", "Test failed");
  }

}
