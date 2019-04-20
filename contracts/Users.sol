pragma solidity ^0.5.0;

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
