pragma solidity 0.5.0;

contract Users{
  struct User{
    uint dateCreated;
    uint id;
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
}
