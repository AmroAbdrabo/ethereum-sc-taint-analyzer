pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
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

  function foo(address x) public {
    set1(y, x);
    // inside this call, in set3,
    // if the execution goes through require(msg.sender == c) (a guard), x becomes trusted and is assigned to b.
    // otherwise, b remains the old trusted value.
    // b also implicitly depends on j, which holds the trusted value of y.
    // so b is always trusted.
    require(msg.sender == b); // guard
    selfdestruct(msg.sender); // safe
  }
}
