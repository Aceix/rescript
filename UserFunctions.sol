pragma solidity ^0.5.0;

import {Users} from "./Users.sol";
import {SchoolFunctions} from "./SchoolFunctions.sol";

contract UserFunctions{
  address usersContractAddr = 0x1c467290D104FED1Fe910CF6b4cedAEE4587a643;
  address schoolFunctionsContractAddr = 0x2923D3c2d76c3B4514958835A3EF19694C49d96C;
  Users u = Users(usersContractAddr);
  SchoolFunctions sF = SchoolFunctions(schoolFunctionsContractAddr);

  struct UserTranscriptRequestForm{
    uint uid;
    uint oldSchoolID;
  }
  
  // list of tmp user request forms
  UserTranscriptRequestForm[] userTranscriptRequestForms;

  // func to process transcript request
  // RETURN: 0 = FAILED; 1 = SUCCESS
  function onTranscriptRequest(
    uint _sid,
    uint _oldSchoolID
  ) public returns (uint8){
    if(!isLoggedIn(_sid)) return 0;
    userTranscriptRequestForms.push(
      UserTranscriptRequestForm({
        uid: _sid,
        oldSchoolID: _oldSchoolID
      })
    );
    sF.addTranscriptRequest(
      _sid,
      _oldSchoolID,
      u.getUserName(_sid),
      u.getUserYearCompleted(_sid),
      u.getUserRefNumber(_sid),
      u.getUserEmail(_sid)
    );
    return 1;
  }

  // func to handle sending the transcription to prospec school
  // RETURNS 0 = FAIL; 1 = SUCCESS
  function onTranscriptForward(
    uint _sid,
    uint _prospecSchoolID
  ) public returns (uint8){
    if(!isLoggedIn(_sid)) return 0;
    sF.addTranscriptReceive(
      _sid,
      _prospecSchoolID,
      u.getUserTranscriptHash(_sid),
      u.getUserName(u.getUserPrevInst(_sid)),
      u.getUserName(_sid)
    );
    return 1;
  }

  // get the hash if its available
  // RETURN; 0 = UNAVAILABLE; <HASH> = AVAILABLE
  function getTranscriptHash(uint _sid) public view returns (string memory){
    return u.getUserTranscriptHash(_sid);
  }
  
  // func to verify login
  function isLoggedIn(uint _sid) internal returns (bool){
    return u.isAuthed(_sid);
  }
}
