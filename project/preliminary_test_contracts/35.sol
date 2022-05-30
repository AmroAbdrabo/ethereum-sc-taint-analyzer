pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address a;
  address b;
  address c;
  int y;

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
    } else {
      require(msg.sender == c);
      b = x;
    }
  }

  // assume that before foo is called, an untrusted user calls set3 and goes through the if branch at line 22, which makes b untrusted due to implicit dependency on untrusted j.
  // then, inside the call to set1 at line 33, the if branch at line 12 is not taken, b remains untrusted.
  function foo(address x) public {
    set1(y, x);
    require(msg.sender == b); // not a guard 
    selfdestruct(msg.sender); // vulnerable
  }
}
