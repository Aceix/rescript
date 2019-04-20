pragma solidity ^0.5.0;

import {Users} from "./Users.sol";

contract SchoolFunctions{
  struct SchoolTranscriptRequest{
    uint studentID;
    string studentName;
    uint yearOfCompletion;
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
    uint _schoolID,
    uint _studentID,
    string memory _studentName,
    uint _yearOfCompletion,
    string memory _refNumber,
    string memory _email
  ) public{
    require(_schoolID > 0);
    require(_studentID > 0);

    schoolTranscriptRequestList[_schoolID].push(
      SchoolTranscriptRequest({
        studentID: _studentID,
        studentName: _studentName,
        yearOfCompletion: _yearOfCompletion,
        refNumber: _refNumber,
        email: _email
      })
    );
  }

  // func to add to school receive list
  function addTranscriptReceive(
    uint _schoolID,
    string memory _hashString,
    string memory _oldSchoolName,
    string memory _studentName
  ) public{
    schoolTranscriptReceiveList[_schoolID].push(
      SchoolTranscriptReceive({
        hashString: _hashString,
        oldSchoolName: _oldSchoolName,
        studentName: _studentName
      })
    );
  }

  // func to verify login
  function isLoggedIn(uint sid){
    User u = User();
    return u.isAuthed(sid);
  }
}
