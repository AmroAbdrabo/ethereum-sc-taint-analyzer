pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address a;
  function foo(int i) public {
    if (i > 5) {
      a = msg.sender;
      a = address(0xDEADBEEF);
      require(msg.sender == a); // guard
      selfdestruct(msg.sender); // safe
    }
  }
}
