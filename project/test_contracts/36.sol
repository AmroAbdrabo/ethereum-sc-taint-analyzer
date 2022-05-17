pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address payable a;
  address payable b;
  address payable c;
  int unsafe_int;

  function set_unsafe_int(int i) public {
    unsafe_int = i;
  }

  function set1(int i, address payable x) public {
    if (i > 5) {
      set2(x);
    }
  }

  function set2(address payable x) public {
    set3(x, 2);
  }

  function set3(address payable x, int j) public {
    if (j != 1) {
      a = x;
    } else {
      require(msg.sender == c);
      b = x;
    }
  }

  function foo(address payable x) public {
    set1(6, x);
    require(msg.sender == b); // guard
    set3(x, unsafe_int);
    // x is trusted but b implicitly depends on untrusted unsafe_int
    selfdestruct(b); // vulnerable
  }
}
