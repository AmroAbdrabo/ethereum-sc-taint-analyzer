pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  function foo(int i) public {
    address x;
    if (i > 5) {
      x = address(0xDEADBEEF);
      require(msg.sender == x); // guard
      selfdestruct(msg.sender); // safe. execution of the if branch stops here
    }
  }
}
