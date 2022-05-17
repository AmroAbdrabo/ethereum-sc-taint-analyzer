pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address payable owner;
  address payable x;

  function foo1(address payable y) public {
    x = y;
  }

  function foo2() public {
    require(msg.sender == owner); // not a guard
    owner = x;
  }

  function foo3() public {
    selfdestruct(owner); // vulnerable
  }
}
