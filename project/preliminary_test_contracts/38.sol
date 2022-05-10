pragma solidity ^0.5.0;

// the contract is safe 
// the output of your analyzer should be Safe
contract Contract {
  address a;
  address b;
  address c;
  address d;
  address owner;

  function set_a() public {
    a = msg.sender; // a becomes trusted after seeing the guard
    require(msg.sender == owner); // guard
  }

  function set_b() public {
    b = msg.sender; // b becomes trusted after seeing the guard
    require(msg.sender == a); // guard
  }

  function set_c() public {
    c = msg.sender; // c becomes trusted after seeing the guard
    require(msg.sender == b); // guard
  }

  function set_d() public {
    d = msg.sender; // d becomes trusted after seeing the guard
    require(msg.sender == c); // guard
  }

  function bar() public {
    if (msg.sender == d) {} // guard
    selfdestruct(msg.sender); // safe
  }
}
