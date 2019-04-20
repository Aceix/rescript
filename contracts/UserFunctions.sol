pragma solidity ^0.5.0;

import {Users} from "./Users.sol";
import {SchoolFunctions} from "./SchoolFunctions.sol";

contract UserFunctions{
  address usersContractAddr = "";
  User u = User(usersContractAddr);

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
        uid: sid,
        oldSchoolID: _oldSchoolID
      })
    );
    addTranscriptRequest(
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
    uint _prosecSchoolID
  ) returns (uint8){
    if(!isLoggedIn(_sid)) return 0;
    addTranscriptReceive(
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
  function getTranscriptHash(uint _sid) public view returns (string){
    return u.getUserTranscriptHash(_sid);
  }
  
  // func to verify login
  function isLoggedIn(uint sid){
    return u.isAuthed(sid);
  }
}
