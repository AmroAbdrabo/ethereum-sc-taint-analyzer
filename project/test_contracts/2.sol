pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function foo(address x) public {
    require(x == owner);        // not a guard
    selfdestruct(msg.sender);   // vulnerable 
  }
}
