pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address payable owner;

  function registerUser() public {
    user = address(0xDEADBEEF);
    user = msg.sender;
  }

  function changeOwner(address payable newOwner) public {
    require(msg.sender == user);
    owner = address(0xDAADBEEF);
    owner = newOwner;
  }

  function kill() public {
    selfdestruct(owner);
  }
}
