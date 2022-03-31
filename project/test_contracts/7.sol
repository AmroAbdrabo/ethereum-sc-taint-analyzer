pragma solidity ^0.5.0;

contract Contract {
  address payable owner;
  address payable admin;
  int c;
  function setc(int newc) public {
    c = newc;
  }
  function foo() public {
    address addr = owner;
    if (c > 0) addr = admin;
    require(msg.sender == addr);  // not a guard
    selfdestruct(msg.sender);     // vulnerable
  }
  function bar() public {
    address addr = admin;
    if (msg.sender == admin) addr = owner;
    require(addr == address(0xDEADBEEF));  // guard
    selfdestruct(msg.sender);              // safe
  }
}
