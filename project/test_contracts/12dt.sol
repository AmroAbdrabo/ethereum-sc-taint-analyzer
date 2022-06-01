pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address x;
  function foo(int i, address j) public {
    if (i > 5) {
      x = j;
      require(msg.sender == x); // not guard
      selfdestruct(msg.sender); // vulnerable. execution of the if branch stops here
    }
  }
}
