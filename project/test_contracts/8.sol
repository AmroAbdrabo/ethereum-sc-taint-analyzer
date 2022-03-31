pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function check(address x) public returns(bool) {
    return (msg.sender == x);
  }
  function foo() public {
    require(check(owner));         // guard
    selfdestruct(msg.sender);      // safe
  }
  function bar(address z) public {
    require(check(z));             // not a guard
    selfdestruct(msg.sender);      // vulnerable
  }
}
