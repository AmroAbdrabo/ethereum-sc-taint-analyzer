pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  function foo(int i) public {
    address x;
    if (i > 5) {
      x = address(0xDEADBEEF);
      require(msg.sender == x); // not a guard
      selfdestruct(msg.sender); // vulnerable
    }
  }
}
