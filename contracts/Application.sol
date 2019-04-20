pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import {StringUtils} from "../libraries/StringUtils.sol";

contract Users{
  struct User{
    uint id;
    string email;
    string passHash;
    UserData data;
  }

  struct UserData{
    uint accType;  // 0 = student; 1 = school;
    string name;
    string email;
    string mobile;

    // SCHOOL ONLY
    string location;
    
    // STUDENT ONLY
    uint prevInst;
    uint yearCompleted;
    string refNumber;
    string transcriptHash;
  }

  // current uid
  // this var is to ensure unique user ids for each user
  uint cUID;

  // users array/DB
  User[] private users;

  // active session list
  // note that sessionID = userID
  uint[] private activeSessions;

  constructor() public{
    // id of 0 means nothing
    cUID = 1;
  }

  // function to create new user acc
  function createUser(
    string memory _email,
    string memory _passHash,
    uint _accType,
    string memory _name,
    string memory _mobile,
    string memory _location,
    uint _prevInst,
    uint _yearCompleted,
    string memory _refNumber,
    string memory _transcriptHash
  ) public returns (uint){
    users.push(
      User({
        id: cUID++,
        email: _email,
        passHash: _passHash,
        data: UserData({
          accType: _accType,
          name: _name,
          email: _email,
          mobile: _mobile,
          location: _location,
          prevInst: _prevInst,
          yearCompleted: _yearCompleted,
          refNumber: _refNumber,
          transcriptHash: _transcriptHash
        })
      })
    );

    // log user in and return sid
    return loginUser(_email, _passHash);
  }

  // function to login
  function loginUser(
    string memory _email,
    string memory _passHash
  ) public returns (uint) {
    for (uint8 i = 0; i < users.length; i++) {
      if(StringUtils.equal(users[i].email, _email) && StringUtils.equal(users[i].passHash, _passHash)){
        activeSessions.push(users[i].id);
        return users[i].id;
      }
    }
    return 0;
  }

  // func to log user out
  function logoutUser(uint sid) public {
    require(sid > 0);
    for(uint8 i = 0; i < activeSessions.length; i++){
      if(activeSessions[i] == sid) delete activeSessions[i];
    }
  }

  // func to verify user is authorized
  function isAuthed(uint _sid) public view returns (bool) {
    require(_sid > 0);
    for(uint8 i = 0; i < activeSessions.length; i++){
      if(activeSessions[i] == _sid) return true;
    }
    return false;
  }

  // function to set hash
  function setUserTranscriptHash(uint uid, string memory _transcriptHash) public{
    if(!isAuthed(uid)) return;
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == uid){
        users[i].data.transcriptHash = _transcriptHash;
      }
    }
  }

  function getAllRegisteredSchools() public view returns (string[] memory) {
    string[] memory l;
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].data.accType == 1){
        l[i] = users[i].data.name;
      }
    }
    return l;
  }

  
  // user details getters
  // return "" or 0 on FAILURE
  function getUserName(uint _sid) public view returns (string memory){
    // if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.name;
      }
    }
  }

  function getUserEmail(uint _sid) public view returns (string memory){
    if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.email;
      }
    }
  }

  function getUserMobile(uint _sid) public view returns (string memory){
    if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.mobile;
      }
    }
  }

  function getUserLocation(uint _sid) public view returns (string memory){
    if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.location;
      }
    }
  }

  function getUserPrevInst(uint _sid) public view returns (uint){
    if(!isAuthed(_sid)) return 0;
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.prevInst;
      }
    }
  }

  function getUserYearCompleted(uint _sid) public view returns (uint){
    if(!isAuthed(_sid)) return 0;
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.yearCompleted;
      }
    }
  }

  function getUserRefNumber(uint _sid) public view returns (string memory){
    if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.refNumber;
      }
    }
  }

  function getUserTranscriptHash(uint _sid) public view returns (string memory){
    if(!isAuthed(_sid)) return "";
    for (uint8 i = 0; i < users.length; i++) {
      if(users[i].id == _sid){
        return users[i].data.transcriptHash;
      }
    }
  }

}



contract SchoolFunctions{
  address usersContractAddr = 0x1180BCA5076D506Ed97Cb4634bAa639e7b98F9dF;
  Users u = Users(usersContractAddr);

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
        uid: _sid,
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
  ) public{
    if(!isLoggedIn(_sid)) return;
    // store the hash
    u.setUserTranscriptHash(_sid, _transcriptHash);
    
    // delete the request
    for (uint8 i = 0; i < schoolTranscriptRequestList[_sid].length; i++) {
      if(schoolTranscriptRequestList[_sid][i].uid == _uid){
        delete schoolTranscriptRequestList[_sid][i];
      }
    }
  }

  // func to verify login
  function isLoggedIn(uint _sid) view internal returns (bool){
    return u.isAuthed(_sid);
  }
}


contract UserFunctions{
  address usersContractAddr = 0x1180BCA5076D506Ed97Cb4634bAa639e7b98F9dF;
  address schoolFunctionsContractAddr = 0xE636cdE2E9b9a4e40Ad2dbfFF28011A94701f6aA;
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
  function isLoggedIn(uint _sid) view internal returns (bool){
    return u.isAuthed(_sid);
  }
}
