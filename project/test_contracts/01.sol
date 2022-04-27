pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function foo(address payable x) public {
    require(msg.sender == x);         // guard
    selfdestruct(msg.sender);      // safe
  }
  
}
