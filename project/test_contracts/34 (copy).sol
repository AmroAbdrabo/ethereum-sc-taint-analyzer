pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address a;
  address b;
  address c;

  function set1(int i, address x) public {
    if (i > 5) {
      set2(x);
    }
  }

  function set2(address x) public {
    set3(x, 2);
  }

  function set3(address x, int j) public {
    if (j != 1) {
      a = x;
      b = x;
    }
  }

  function foo(address x) public {
    set1(6, x);
    require(msg.sender == b); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
