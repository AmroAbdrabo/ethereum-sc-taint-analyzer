pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address a;
  address b;
  address c;

  function set1(address x, int i) public {
    set2(x, i);
  }

  function set2(address x, int i) public {
    set3(x, i);
  }

  function set3(address x, int i) public {
    set4(x, i);
  }

  function set4(address x, int i) public {
    set5(x, i);
  }

  function set5(address x, int i) public {
    if (i > 0) {
      require(msg.sender == c);
      a = x;
    } else {
      b = x;
    }
  }

  function foo(address x, int i) public {
    set1(x, i);
    require(msg.sender == b); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
