pragma solidity ^0.5.0;

// the contract is safe 
// the output of your analyzer should be Safe
contract Contract {
  address a;
  address b;
  address owner;

  function set_a() public {
    a = msg.sender; // a becomes trusted after seeing the guard
    require(msg.sender == owner); // guard
  }

  function set_b() public {
    b = msg.sender; // b becomes trusted after seeing the guard
    require(msg.sender == a); // guard
  }

  function bar() public {
    if (msg.sender == b) {} // guard
    selfdestruct(msg.sender); // safe
  }
}
