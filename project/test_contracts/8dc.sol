pragma solidity ^0.5.0;

contract Contract {
  address owner;
  address b;
  function check(address x) public returns(bool) {
    address k = address(0xDEADBEEF);
    return (msg.sender == k);
  }
  function foo() public {
    owner = msg.sender;
    owner = b;
    require(check(owner));         // guard
    selfdestruct(msg.sender);      // safe
  }
  function bar(address z) public {
    require(check(z));             // guard
    selfdestruct(msg.sender);      // safe
  }
}

