pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address owner;
  address a;

  function set_a1(address x) public {
    set_a2(x);
  }

  function set_a2(address x) public {
    a = x;
  }

  function foo(address x) public {
    set_a1(owner);
    set_a1(x);
    require(msg.sender == a); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
