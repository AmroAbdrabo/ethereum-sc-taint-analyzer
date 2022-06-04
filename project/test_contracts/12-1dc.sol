pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address x;
  function foo(int i) public {
    if (i > 5) {
      x = address(0xDEADBEEF);
    }
    x = msg.sender;
    //x = address(0xDEADBEEF);
    require(msg.sender == x); // guard
    selfdestruct(msg.sender); // safe
  }
}
