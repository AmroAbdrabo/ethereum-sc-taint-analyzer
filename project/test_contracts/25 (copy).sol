pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address a;
  address b;
  address c;

  function set_a() public {
    a = msg.sender;
  }

  function set_b() public {
    b = msg.sender;
    require(msg.sender == a); // not a guard
  }

  function set_c() public {
    c = msg.sender;
    require(msg.sender == b); // not a guard
  }

  function bar() public {
    require(msg.sender == c); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
