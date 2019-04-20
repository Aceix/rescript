pragma solidity ^0.5.0;

import {Users} from "./Users.sol";

contract SchoolFunctions{
  address usersContractAddr = "";

  struct SchoolTranscriptRequest{
    uint uid;
    string studentName;
    uint yearCompleted;
    string refNumber;
    string email;
  }

  struct SchoolTranscriptReceive{
    string hashString;
    string oldSchoolName;
    string studentName;
  }
  
  // school transcript request list
  mapping (uint => SchoolTranscriptRequest[]) public schoolTranscriptRequestList;

  // school transcript receive list
  mapping(uint => SchoolTranscriptReceive[]) public schoolTranscriptReceiveList;


  // func to add to school request list
  function addTranscriptRequest(
    uint _sid,
    uint _oldSchoolID,
    string memory _studentName,
    uint _yearCompleted,
    string memory _refNumber,
    string memory _email
  ) public{
    if(!isLoggedIn(_sid)) return;
    require(_oldSchoolID > 0);

    schoolTranscriptRequestList[_oldSchoolID].push(
      SchoolTranscriptRequest({
        uid: sid,
        studentName: _studentName,
        yearCompleted: _yearCompleted,
        refNumber: _refNumber,
        email: _email
      })
    );
  }

  // func to add to school receive list
  function addTranscriptReceive(
    uint _sid,
    uint _schoolID,
    string memory _hashString,
    string memory _oldSchoolName,
    string memory _studentName
  ) public{
    if(!isLoggedIn(_sid)) return;
    schoolTranscriptReceiveList[_schoolID].push(
      SchoolTranscriptReceive({
        hashString: _hashString,
        oldSchoolName: _oldSchoolName,
        studentName: _studentName
      })
    );
  }

  // func to resolve transcript request
  function resolveTranscriptRequest(
    uint _sid,
    uint _uid,
    string memory _transcriptHash
  ){
    if(!isLoggedIn(_sid)) return;
    // store the hash
    setUserTranscriptHash(_sid, _transcriptHash);
    
    // delete the request
    for (uint8 i = 0; i < schoolTranscriptRequestList[_sid].length; i++) {
      if(schoolTranscriptRequestList[_sid][i].uid == _uid){
        delete schoolTranscriptRequestList[_sid][i];
      }
    }
  }

  // func to verify login
  function isLoggedIn(uint sid){
    User u = User(usersContractAddr);
    return u.isAuthed(sid);
  }
}
