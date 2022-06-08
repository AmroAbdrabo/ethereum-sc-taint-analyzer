pragma solidity ^0.5.0;

contract Contract {
  address payable user;
  address owner;
  function func1(address payable x) public {
    owner = address(0xDEADBEEF);
    user = msg.sender;
    user = x;  // x becomes trusted after seeing the guard
    require(msg.sender == owner);  // guard
  }
  function func2(address payable x) public {
    owner = address(0xDEADBEEF);
    user = msg.sender;
    user = x;  // x becomes trusted after seeing the guard
    if (msg.sender == owner) {}  // guard
  }
  function func3() public {
    selfdestruct(user); // safe
  }
}
