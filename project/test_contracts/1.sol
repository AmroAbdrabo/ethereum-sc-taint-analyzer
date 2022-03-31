pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser() public {
    user = msg.sender;
  }

  function changeOwner(address payable newOwner) public {
    require(msg.sender == user);
    owner = newOwner;
  }

  function kill() public {
    selfdestruct(owner);
  }
}
