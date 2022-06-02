pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address a;
  address b;
  address c;

  /*function set1(address x, int i) public {
    set2(x, i);
  }*/

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
    set2(x, i);
    // if the execution goes through require(msg.sender == c) (a guard), x and i become trusted.
    // otherwise, a remain the old trusted value.
    require(msg.sender == a); // guard
    selfdestruct(msg.sender); // safe
  }
}
