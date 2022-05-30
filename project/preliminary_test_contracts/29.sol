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
      require(msg.sender == c); // guard
      a = x;
    } else {
      b = x;
    }
  }

  function foo(address x, int i) public {
    set1(x, i);
    // inside this call, in set5, a and b implicitly depend on i.
    // if the execution goes through the if branch, the guard require(msg.sender == c) makes x and i trusted.
    // otherwise, i and x are untrusted, and a is therefore untrusted due to implicit dependency on i.
    require(msg.sender == a); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
