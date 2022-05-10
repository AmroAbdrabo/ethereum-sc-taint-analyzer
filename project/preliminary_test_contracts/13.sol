pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  function foo(int i) public {
    if (i > 5) {
      require(msg.sender == address(0xDEADBEEF)); // guard
      selfdestruct(msg.sender); // safe
    }
  }
}
