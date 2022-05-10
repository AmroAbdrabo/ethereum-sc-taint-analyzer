pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address owner;
  address a;

  function check(address x) public returns(bool) {
    return check_impl(x);
  }

  function check_impl(address x) public returns(bool) {
    return (msg.sender == x);
  }

  function foo() public {
    require(check(owner)); // guard, essentially msg.sender == owner
    a = msg.sender;
  }

  function bar() public {
    require(check(a)); // guard
    selfdestruct(msg.sender); // safe
  }
}
