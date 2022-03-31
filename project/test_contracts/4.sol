pragma solidity ^0.5.0;

contract Contract {
  address owner;
  int y;
  function func1() public {
    require(msg.sender != owner); // guard
    selfdestruct(msg.sender);     // safe
  }
  function func2() public {
    require(msg.sender == owner || true); // guard
    selfdestruct(msg.sender);             // safe
  }
  function func3() public {
    require(msg.sender == msg.sender); // guard
    selfdestruct(msg.sender);          // safe
  }
  function func4(int x) public {
    y = y + x;  // y is untrusted
    y = y - x;  // y is untrusted
    require(msg.sender == owner && y > 1); // not a guard
    selfdestruct(msg.sender);              // vulnerable
  }
}
