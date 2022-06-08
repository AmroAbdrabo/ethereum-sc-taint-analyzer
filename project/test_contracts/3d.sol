pragma solidity ^0.5.0;

contract Contract {
  address owner;
  address admin;
  function changeOnwer1() public {
    admin = address(0xDEADBEEF);
    owner = admin;
  }
  function changeOnwer2() public {
    admin = address(0xDEADBEEF);
    owner = msg.sender;
    owner = address(0xDEADBEEF);
  }
  function kill() public {
    require(msg.sender == owner); // guard
    selfdestruct(msg.sender);     // safe
  }
}
