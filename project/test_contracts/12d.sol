pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address x;
  function foo(int i, address j) public {
    if (i > 5) {
      x = j;
      x = address(0xDEADBEEF);
      require(msg.sender == x); // guard
      selfdestruct(msg.sender); // safe. execution of the if branch stops here
    }
  }
}
