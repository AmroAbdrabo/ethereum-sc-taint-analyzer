pragma solidity ^0.5.0;

// the contract is safe 
// the output of your analyzer should be Safe
contract Contract {
  address x;
  address y;
  address payable owner;

  function set_y() public {
    y = msg.sender;
  }

  function foo() public {
    x = y;
    y = address(0xDEADBEEF);
    selfdestruct(owner); // safe since owner is never changed
  }

  function bar() public {
    require(msg.sender == x); // guard 
    // x is either safe
    // or the contract is destructed after calling foo, meaning that users cannot send any new transactions to the contract
    selfdestruct(msg.sender); // safe
  }
}